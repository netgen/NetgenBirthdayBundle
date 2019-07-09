<?php

namespace Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday;

use DateTime;
use eZ\Publish\API\Repository\Values\ContentType\FieldDefinition;
use eZ\Publish\Core\Base\Exceptions\InvalidArgumentType;
use eZ\Publish\Core\FieldType\FieldType;
use eZ\Publish\Core\FieldType\ValidationError;
use eZ\Publish\Core\FieldType\Value as BaseValue;
use eZ\Publish\SPI\FieldType\Value as SPIValue;

class Type extends FieldType
{
    /**
     * @const int
     */
    const DEFAULT_VALUE_EMPTY = 0;

    /**
     * @const int
     */
    const DEFAULT_VALUE_CURRENT_DATE = 1;

    /**
     * List of settings available for this FieldType.
     *
     * The key is the setting name, and the value is the default value for this setting
     *
     * @var array
     */
    protected $settingsSchema = array(
        'defaultValue' => array(
            'type' => 'integer',
            'default' => self::DEFAULT_VALUE_EMPTY,
        ),
    );

    /**
     * Returns the field type identifier for this field type.
     *
     * @return string
     */
    public function getFieldTypeIdentifier()
    {
        return 'ezbirthday';
    }

    /**
     * Returns a human readable string representation from the given $value.
     *
     * It will be used to generate content name and url alias if current field
     * is designated to be used in the content name/urlAlias pattern.
     *
     * The used $value can be assumed to be already accepted by {@link * acceptValue()}.
     */
    public function getName(SPIValue $value, FieldDefinition $fieldDefinition, string $languageCode): string
    {
        return (string) $value;
    }

    /**
     * Returns the empty value for this field type.
     *
     * @return \eZ\Publish\SPI\FieldType\Value
     */
    public function getEmptyValue()
    {
        return new Value();
    }

    /**
     * Converts an $hash to the Value defined by the field type.
     *
     * @param mixed $hash
     *
     * @return \eZ\Publish\SPI\FieldType\Value
     */
    public function fromHash($hash)
    {
        if (empty($hash)) {
            return $this->getEmptyValue();
        }

        return new Value($hash);
    }

    /**
     * Converts the given $value into a plain hash format.
     *
     * @param \eZ\Publish\SPI\FieldType\Value|\Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value $value
     *
     * @return mixed
     */
    public function toHash(SPIValue $value)
    {
        return (string) $value;
    }

    /**
     * Validates the fieldSettings of a FieldDefinitionCreateStruct or FieldDefinitionUpdateStruct.
     *
     * @param mixed $fieldSettings
     *
     * @return \eZ\Publish\SPI\FieldType\ValidationError[]
     */
    public function validateFieldSettings($fieldSettings)
    {
        $validationErrors = array();
        if (!is_array($fieldSettings)) {
            $validationErrors[] = new ValidationError('Field settings must be in form of an array');

            return $validationErrors;
        }

        foreach ($fieldSettings as $name => $value) {
            if (!isset($this->settingsSchema[$name])) {
                $validationErrors[] = new ValidationError(
                    "Setting '%setting%' is unknown",
                    null,
                    array(
                        'setting' => $name,
                    )
                );
                continue;
            }

            switch ($name) {
                case 'defaultValue':
                    if (!is_int($value)) {
                        $validationErrors[] = new ValidationError(
                            "Setting '%setting%' value must be of integer type",
                            null,
                            array(
                                'setting' => $name,
                            )
                        );
                    } else {
                        if ($value !== self::DEFAULT_VALUE_EMPTY && $value !== self::DEFAULT_VALUE_CURRENT_DATE) {
                            $validationErrors[] = new ValidationError(
                                "Setting '%setting%' value must be either Type::DEFAULT_VALUE_EMPTY or Type::DEFAULT_VALUE_CURRENT_DATE",
                                null,
                                array(
                                    'setting' => $name,
                                )
                            );
                        }
                    }

                    break;
            }
        }

        return $validationErrors;
    }

    /**
     * Returns whether the field type is searchable.
     *
     * @return bool
     */
    public function isSearchable()
    {
        return true;
    }

    /**
     * Inspects given $inputValue and potentially converts it into a dedicated value object.
     *
     * If given $inputValue could not be converted or is already an instance of dedicate value object,
     * the method should simply return it.
     *
     * @param mixed $inputValue
     *
     * @return mixed The potentially converted input value
     */
    protected function createValueFromInput($inputValue)
    {
        if ($inputValue instanceof DateTime || is_string($inputValue)) {
            return new Value($inputValue);
        }

        return $inputValue;
    }

    /**
     * Throws an exception if value structure is not of expected format.
     *
     * Note that this does not include validation after the rules
     * from validators, but only plausibility checks for the general data
     * format.
     *
     *
     * @param \eZ\Publish\Core\FieldType\Value|\Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value $value
     *
     * @throws \eZ\Publish\API\Repository\Exceptions\InvalidArgumentException If the value does not match the expected structure
     */
    protected function checkValueStructure(BaseValue $value)
    {
        if (!$value->date instanceof DateTime) {
            throw new InvalidArgumentType(
                '$value->date',
                'DateTime',
                $value->date
            );
        }
    }

    /**
     * Returns information for FieldValue->$sortKey relevant to the field type.
     *
     * Return value is mixed. It should be something which is sensible for
     * sorting.
     *
     * It is up to the persistence implementation to handle those values.
     * Common string and integer values are safe.
     *
     * For the legacy storage it is up to the field converters to set this
     * value in either sort_key_string or sort_key_int.
     *
     * @param \eZ\Publish\Core\FieldType\Value $value
     *
     * @return mixed
     */
    protected function getSortInfo(BaseValue $value)
    {
        return (string) $value;
    }
}
