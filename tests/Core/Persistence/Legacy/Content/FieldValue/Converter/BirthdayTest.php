<?php

declare(strict_types=1);

namespace Netgen\Bundle\BirthdayBundle\Tests\Core\Persistence\Legacy\Content\FieldValue\Converter;

use Ibexa\Contracts\Core\Persistence\Content\FieldValue;
use Ibexa\Contracts\Core\Persistence\Content\Type\FieldDefinition;
use Ibexa\Core\Persistence\Legacy\Content\FieldValue\Converter;
use Ibexa\Core\Persistence\Legacy\Content\StorageFieldDefinition;
use Ibexa\Core\Persistence\Legacy\Content\StorageFieldValue;
use Netgen\Bundle\BirthdayBundle\Core\Persistence\Legacy\Content\FieldValue\Converter\Birthday;
use PHPUnit\Framework\TestCase;

final class BirthdayTest extends TestCase
{
    private Birthday $converter;

    protected function setUp(): void
    {
        $this->converter = new Birthday();
    }

    public function testInstanceOfConverter(): void
    {
        self::assertInstanceOf(Converter::class, $this->converter);
    }

    public function testGetIndexColumn(): void
    {
        self::assertSame('sort_key_string', $this->converter->getIndexColumn());
    }

    public function testToStorageValue(): void
    {
        $fieldValue = new FieldValue(
            [
                'data' => 'data',
                'sortKey' => 'sortKey',
            ]
        );
        $storageFieldValue = new StorageFieldValue();

        $this->converter->toStorageValue($fieldValue, $storageFieldValue);
    }

    public function testToFieldValue(): void
    {
        $storageFieldValue = new StorageFieldValue(
            [
                'dataText' => 'data',
                'sortKeyString' => 'sortKey',
            ]
        );
        $fieldValue = new FieldValue();

        $this->converter->toFieldValue($storageFieldValue, $fieldValue);
    }

    public function testToStorageFieldDefinition(): void
    {
        $fieldDefinition = new FieldDefinition();
        $fieldDefinition->fieldTypeConstraints->fieldSettings = ['defaultValue' => 'some_value'];
        $storageFieldDefinition = new StorageFieldDefinition();

        $this->converter->toStorageFieldDefinition($fieldDefinition, $storageFieldDefinition);
    }

    public function testToFieldDefinition(): void
    {
        $storageFieldDefinition = new StorageFieldDefinition();
        $storageFieldDefinition->dataText1 = 1;
        $fieldDefinition = new FieldDefinition();

        $this->converter->toFieldDefinition($storageFieldDefinition, $fieldDefinition);
    }
}
