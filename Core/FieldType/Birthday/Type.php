<?php

namespace Netgen\BirthdayBundle\Core\FieldType\Birthday;

use eZ\Publish\Core\Base\Exceptions\InvalidArgumentType;

use eZ\Publish\Core\FieldType\FieldType;
use eZ\Publish\Core\FieldType\Value as BaseValue;
use eZ\Publish\SPI\FieldType\Value as SPIValue;
use eZ\Publish\SPI\Persistence\Content\FieldValue;

class Type extends FieldType
{
    public function getFieldTypeIdentifier()
    {
        return "ezbirthday";
    }

    public function getEmptyValue()
    {
        return new Value;
    }

    public function getName( SPIValue $value )
    {
        return (string) $value;
    }

    public function fromHash( $hash )
    {
        if ( $hash === null || empty( $hash ) )
        {
            return $this->getEmptyValue();
        }

        return new Value( $hash );
    }

    public function toHash( SPIValue $value )
    {
        if ( $this->isEmptyValue( $value ) )
        {
            return null;
        }
        return $value->date;
    }

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

    public function fromPersistenceValue( FieldValue $fieldValue )
    {
        return new Value( $fieldValue->data );
    }

    protected function getSortInfo( BaseValue $value )
    {
        return $this->getName( $value );
    }

    protected function createValueFromInput( $inputValue )
    {
        if ( !empty( $inputValue ) )
            return new Value( $inputValue );

        return parent::createValueFromInput( $inputValue );
    }

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