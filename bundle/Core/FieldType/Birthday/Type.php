<?php

declare(strict_types=1);

namespace Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday;

use DateTimeInterface;
use Ibexa\Contracts\Core\FieldType\Value as SPIValue;
use Ibexa\Contracts\Core\Repository\Values\ContentType\FieldDefinition;
use Ibexa\Core\Base\Exceptions\InvalidArgumentType;
use Ibexa\Core\FieldType\FieldType;
use Ibexa\Core\FieldType\ValidationError;
use Ibexa\Core\FieldType\Value as BaseValue;

use function is_array;
use function is_int;
use function is_string;

final class Type extends FieldType
{
    public const int DEFAULT_VALUE_EMPTY = 0;

    public const int DEFAULT_VALUE_CURRENT_DATE = 1;

    /**
     * @var array<string, array<string, mixed>>
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
     * @return \Ibexa\Contracts\Core\FieldType\Value|\Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value
     */
    public function getEmptyValue(): SPIValue
    {
        return new Value();
    }

    /**
     * @param mixed $hash
     *
     * @return \Ibexa\Contracts\Core\FieldType\Value|\Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value
     */
    public function fromHash($hash): SPIValue
    {
        if (empty($hash)) {
            return $this->getEmptyValue();
        }

        return new Value($hash);
    }

    /**
     * @param \Ibexa\Contracts\Core\FieldType\Value|\Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value $value
     *
     * @return mixed
     */
    public function toHash(SPIValue $value): mixed
    {
        return (string) $value;
    }

    /**
     * @param mixed $fieldSettings
     *
     * @return \Ibexa\Contracts\Core\FieldType\ValidationError[]
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

            if ($name === 'defaultValue') {
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
     * @param \Ibexa\Core\FieldType\Value|\Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value $value
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

    protected function getSortInfo(BaseValue $value): string
    {
        return (string) $value;
    }
}
