<?php

declare(strict_types=1);

namespace Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday;

use DateTimeInterface;
use eZ\Publish\API\Repository\Values\ContentType\FieldDefinition;
use eZ\Publish\Core\Base\Exceptions\InvalidArgumentType;
use eZ\Publish\Core\FieldType\FieldType;
use eZ\Publish\Core\FieldType\ValidationError;
use eZ\Publish\Core\FieldType\Value as BaseValue;
use eZ\Publish\SPI\FieldType\Value as SPIValue;

final class Type extends FieldType
{
    /**
     * @const int
     */
    public const DEFAULT_VALUE_EMPTY = 0;

    /**
     * @const int
     */
    public const DEFAULT_VALUE_CURRENT_DATE = 1;

    /**
     * @var array
     */
    protected $settingsSchema = [
        'defaultValue' => [
            'type' => 'integer',
            'default' => self::DEFAULT_VALUE_EMPTY,
        ],
    ];

    public function getFieldTypeIdentifier(): string
    {
        return 'ezbirthday';
    }

    public function getName(SPIValue $value, FieldDefinition $fieldDefinition, string $languageCode): string
    {
        return (string) $value;
    }

    /**
     * @return \eZ\Publish\SPI\FieldType\Value|\Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value
     */
    public function getEmptyValue(): SPIValue
    {
        return new Value();
    }

    /**
     * @param mixed $hash
     *
     * @return \eZ\Publish\SPI\FieldType\Value|\Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value
     */
    public function fromHash($hash): SPIValue
    {
        if (empty($hash)) {
            return $this->getEmptyValue();
        }

        return new Value($hash);
    }

    /**
     * @param \eZ\Publish\SPI\FieldType\Value|\Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value $value
     *
     * @return mixed
     */
    public function toHash(SPIValue $value)
    {
        return (string) $value;
    }

    /**
     * @param mixed $fieldSettings
     *
     * @return \eZ\Publish\SPI\FieldType\ValidationError[]
     */
    public function validateFieldSettings($fieldSettings): array
    {
        $validationErrors = [];
        if (!is_array($fieldSettings)) {
            $validationErrors[] = new ValidationError('Field settings must be in form of an array');

            return $validationErrors;
        }

        foreach ($fieldSettings as $name => $value) {
            if (!isset($this->settingsSchema[$name])) {
                $validationErrors[] = new ValidationError(
                    "Setting '%setting%' is unknown",
                    null,
                    [
                        'setting' => $name,
                    ]
                );

                continue;
            }

            switch ($name) {
                case 'defaultValue':
                    if (!is_int($value)) {
                        $validationErrors[] = new ValidationError(
                            "Setting '%setting%' value must be of integer type",
                            null,
                            [
                                'setting' => $name,
                            ]
                        );
                    } elseif ($value !== self::DEFAULT_VALUE_EMPTY && $value !== self::DEFAULT_VALUE_CURRENT_DATE) {
                        $validationErrors[] = new ValidationError(
                            "Setting '%setting%' value must be either Type::DEFAULT_VALUE_EMPTY or Type::DEFAULT_VALUE_CURRENT_DATE",
                            null,
                            [
                                'setting' => $name,
                            ]
                        );
                    }

                    break;
            }
        }

        return $validationErrors;
    }

    public function isSearchable(): bool
    {
        return true;
    }

    protected function createValueFromInput($inputValue)
    {
        if ($inputValue instanceof DateTimeInterface || is_string($inputValue)) {
            return new Value($inputValue);
        }

        return $inputValue;
    }

    /**
     * @param \eZ\Publish\Core\FieldType\Value|\Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value $value
     */
    protected function checkValueStructure(BaseValue $value): void
    {
        if (!$value->date instanceof DateTimeInterface) {
            throw new InvalidArgumentType(
                '$value->date',
                'DateTime',
                $value->date
            );
        }
    }

    protected function getSortInfo(BaseValue $value)
    {
        return (string) $value;
    }
}
