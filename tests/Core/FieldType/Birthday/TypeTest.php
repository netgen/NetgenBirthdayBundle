<?php

declare(strict_types=1);

namespace Netgen\Bundle\BirthdayBundle\Tests\Core\FieldType\Birthday;

use DateTimeImmutable;
use eZ\Publish\Core\Base\Exceptions\InvalidArgumentType;
use eZ\Publish\Core\FieldType\ValidationError;
use eZ\Publish\Core\Repository\Values\ContentType\FieldDefinition;
use eZ\Publish\SPI\FieldType\FieldType;
use Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Type;
use Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value;
use PHPUnit\Framework\TestCase;

class TypeTest extends TestCase
{
    /**
     * @var Type
     */
    protected $type;

    protected function setUp(): void
    {
        $this->type = new Type();
    }

    public function testInstanceOfFieldType()
    {
        self::assertInstanceOf(FieldType::class, $this->type);
    }

    public function testIsSearchable()
    {
        self::assertTrue($this->type->isSearchable());
    }

    public function testGetFieldTypeIdentifier()
    {
        self::assertSame('ezbirthday', $this->type->getFieldTypeIdentifier());
    }

    public function testGetEmptyValue()
    {
        $value = new Value();

        self::assertSame($value, $this->type->getEmptyValue());
    }

    public function testGetName()
    {
        $spiValue = new Value();

        self::assertSame((string) $spiValue, $this->type->getName($spiValue, new FieldDefinition(), 'eng-GB'));
    }

    public function testToHash()
    {
        $spiValue = new Value();

        self::assertSame((string) $spiValue, $this->type->toHash($spiValue));
    }

    public function testFromHash()
    {
        $dt = new DateTimeImmutable();
        $spiValue = new Value($dt);

        self::assertSame($spiValue, $this->type->fromHash($dt));
    }

    public function testFromHashWithEmptyHash()
    {
        $spiValue = new Value();

        self::assertSame($spiValue, $this->type->fromHash(''));
    }

    public function testValidateFieldSettingWithFieldSettingAsString()
    {
        $validationError = new ValidationError('Field settings must be in form of an array');

        $errors = $this->type->validateFieldSettings('test');

        self::assertSame($validationError, $errors[0]);
    }

    public function testValidateFieldSettingsWithUnknownSetting()
    {
        $fieldSettings = [
            'test' => [],
        ];

        $validationError = new ValidationError(
            "Setting '%setting%' is unknown",
            null,
            [
                'setting' => 'test',
            ]
        );

        $errors = $this->type->validateFieldSettings($fieldSettings);

        self::assertSame($validationError, $errors[0]);
    }

    public function testValidateFieldSettingsWithInvalidDefaultValue()
    {
        $fieldSettings = [
            'defaultValue' => false,
        ];

        $validationError = new ValidationError(
            "Setting '%setting%' value must be of integer type",
            null,
            [
                'setting' => 'defaultValue',
            ]
        );

        $errors = $this->type->validateFieldSettings($fieldSettings);

        self::assertSame($validationError, $errors[0]);
    }

    public function testValidateFieldSettings()
    {
        $fieldSettings = [
            'defaultValue' => 5,
        ];

        $validationError = new ValidationError(
            "Setting '%setting%' value must be either Type::DEFAULT_VALUE_EMPTY or Type::DEFAULT_VALUE_CURRENT_DATE",
            null,
            [
                'setting' => 'defaultValue',
            ]
        );

        $errors = $this->type->validateFieldSettings($fieldSettings);

        self::assertSame($validationError, $errors[0]);
    }

    public function testAcceptValueWithDateTimeAsInput()
    {
        $dt = new DateTimeImmutable();

        $this->type->acceptValue($dt);
    }

    public function testAcceptValueWithValue()
    {
        $dt = new DateTimeImmutable();
        $value = new Value($dt);

        $this->type->acceptValue($value);
    }

    public function testAcceptValueWithInvalidValue()
    {
        $this->expectException(InvalidArgumentType::class);
        $this->expectExceptionMessage("Argument '\$value->date' is invalid: expected value to be of type 'DateTime', got 'string'");

        $value = new Value();
        $value->date = 'test';

        $this->type->acceptValue($value);
    }

    public function testToPersistenceValue()
    {
        $value = new Value(new DateTimeImmutable());

        $this->type->toPersistenceValue($value);
    }
}
