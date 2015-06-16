<?php

namespace Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday;

use eZ\Publish\Core\Base\Exceptions\InvalidArgumentType;

use eZ\Publish\Core\FieldType\FieldType;
use eZ\Publish\Core\FieldType\Value as BaseValue;
use eZ\Publish\SPI\FieldType\Value as SPIValue;
use eZ\Publish\SPI\Persistence\Content\FieldValue;

class Type extends FieldType
{
    /**
     * Returns the field type identifier for this field type
     *
     * @return string
     */
    public function getFieldTypeIdentifier()
    {
        return "ezbirthday";
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
     * Returns a human readable string representation from the given $value
     *
     * It will be used to generate content name and url alias if current field
     * is designated to be used in the content name/urlAlias pattern.
     *
     * The used $value can be assumed to be already accepted by {@link
     * acceptValue()}.
     *
     * @param \eZ\Publish\SPI\FieldType\Value $value
     *
     * @return string
     */
    public function getName( SPIValue $value )
    {
        return (string)$value;
    }

    /**
     * Converts an $hash to the Value defined by the field type
     *
     * @param mixed $hash
     *
     * @return \eZ\Publish\SPI\FieldType\Value
     */
    public function fromHash( $hash )
    {
        if ( empty( $hash ) )
        {
            return $this->getEmptyValue();
        }

        return new Value( $hash );
    }

    /**
     * Converts the given $value into a plain hash format
     *
     * @param \eZ\Publish\SPI\FieldType\Value|\Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value $value
     *
     * @return mixed
     */
    public function toHash( SPIValue $value )
    {
        if ( $this->isEmptyValue( $value ) )
        {
            return null;
        }

        return $value->date;
    }

    /**
     * Converts a $value to a persistence value.
     *
     * @param \eZ\Publish\SPI\FieldType\Value|\Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value $value The value of the field type
     *
     * @return \eZ\Publish\SPI\Persistence\Content\FieldValue the value processed by the storage engine
     */
    public function toPersistenceValue( SPIValue $value )
    {
        return new FieldValue(
            array(
                "data" => $value,
                "externalData" => null,
                "sortKey" => $this->getSortInfo( $value ),
            )
        );
    }

    /**
     * Converts a persistence $value to a Value
     *
     * This method builds a field type value from the $data and $externalData properties.
     *
     * @param \eZ\Publish\SPI\Persistence\Content\FieldValue $fieldValue
     *
     * @return \eZ\Publish\SPI\FieldType\Value
     */
    public function fromPersistenceValue( FieldValue $fieldValue )
    {
        return new Value( $fieldValue->data );
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
    protected function getSortInfo( BaseValue $value )
    {
        return $this->getName( $value );
    }

    /**
     * Inspects given $inputValue and potentially converts it into a dedicated value object.
     *
     * If given $inputValue could not be converted or is already an instance of dedicate value object,
     * the method should simply return it.
     *
     * @param mixed $inputValue
     *
     * @return mixed The potentially converted input value.
     */
    protected function createValueFromInput( $inputValue )
    {
        if ( !empty( $inputValue ) )
        {
            return new Value( $inputValue );
        }

        return parent::createValueFromInput( $inputValue );
    }

    /**
     * Throws an exception if value structure is not of expected format.
     *
     * Note that this does not include validation after the rules
     * from validators, but only plausibility checks for the general data
     * format.
     *
     * @throws \eZ\Publish\API\Repository\Exceptions\InvalidArgumentException If the value does not match the expected structure.
     *
     * @param \eZ\Publish\Core\FieldType\Value|\Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value $value
     *
     * @return void
     */
    protected function checkValueStructure( BaseValue $value )
    {
        if ( !is_string( $value->date ) )
        {
            throw new InvalidArgumentType(
                '$value->date',
                'string',
                $value->date
            );
        }
    }
}
