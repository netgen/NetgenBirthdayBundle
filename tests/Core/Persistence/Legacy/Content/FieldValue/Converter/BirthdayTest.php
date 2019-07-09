<?php

namespace Netgen\Bundle\BirthdayBundle\Tests\Core\Persistence\Legacy\Content\FieldValue\Converter;

use eZ\Publish\Core\Persistence\Legacy\Content\FieldValue\Converter;
use eZ\Publish\Core\Persistence\Legacy\Content\StorageFieldDefinition;
use eZ\Publish\Core\Persistence\Legacy\Content\StorageFieldValue;
use eZ\Publish\SPI\Persistence\Content\FieldValue;
use eZ\Publish\SPI\Persistence\Content\Type\FieldDefinition;
use Netgen\Bundle\BirthdayBundle\Core\Persistence\Legacy\Content\FieldValue\Converter\Birthday;
use PHPUnit\Framework\TestCase;

class BirthdayTest extends TestCase
{
    /**
     * @var Birthday
     */
    protected $converter;

    public function setUp(): void
    {
        $this->converter = new Birthday();
    }

    public function testInstanceOfConverter()
    {
        $this->assertInstanceOf(Converter::class, $this->converter);
    }

    public function testGetIndexColumn()
    {
        $this->assertEquals('sort_key_string', $this->converter->getIndexColumn());
    }

    public function testCreate()
    {
        $this->assertEquals($this->converter, Birthday::create());
    }

    public function testToStorageValue()
    {
        $fieldValue = new FieldValue(
            array(
                'data' => 'data',
                'sortKey' => 'sortKey',
            )
        );
        $storageFieldValue = new StorageFieldValue();

        $this->converter->toStorageValue($fieldValue, $storageFieldValue);
    }

    public function testToFieldValue()
    {
        $storageFieldValue = new StorageFieldValue(
            array(
                'dataText' => 'data',
                'sortKeyString' => 'sortKey',
            )
        );
        $fieldValue = new FieldValue();

        $this->converter->toFieldValue($storageFieldValue, $fieldValue);
    }

    public function testToStorageFieldDefinition()
    {
        $fieldDefinition = new FieldDefinition();
        $fieldDefinition->fieldTypeConstraints->fieldSettings = array('defaultValue' => 'some_value');
        $storageFieldDefinition = new StorageFieldDefinition();

        $this->converter->toStorageFieldDefinition($fieldDefinition, $storageFieldDefinition);
    }

    public function testToFieldDefinition()
    {
        $storageFieldDefinition = new StorageFieldDefinition();
        $storageFieldDefinition->dataText1 = 1;
        $fieldDefinition = new FieldDefinition();

        $this->converter->toFieldDefinition($storageFieldDefinition, $fieldDefinition);
    }
}
