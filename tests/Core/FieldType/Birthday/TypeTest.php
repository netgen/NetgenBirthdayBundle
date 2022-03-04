<?php

declare(strict_types=1);

namespace Netgen\Bundle\BirthdayBundle\Tests\Core\FieldType\Birthday;

use DateTimeImmutable;
use Ibexa\Contracts\Core\FieldType\FieldType;
use Ibexa\Core\Base\Exceptions\InvalidArgumentType;
use Ibexa\Core\FieldType\ValidationError;
use Ibexa\Core\Repository\Values\ContentType\FieldDefinition;
use Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Type;
use Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value;
use PHPUnit\Framework\TestCase;

final class TypeTest extends TestCase
{
    private Type $type;

    protected function setUp(): void
    {
        $this->type = new Type();
    }

    public function testInstanceOfFieldType(): void
    {
        self::assertInstanceOf(FieldType::class, $this->type);
    }

    public function testIsSearchable(): void
    {
        self::assertTrue($this->type->isSearchable());
    }

    public function testGetFieldTypeIdentifier(): void
    {
        self::assertSame('ezbirthday', $this->type->getFieldTypeIdentifier());
    }

    public function testGetEmptyValue(): void
    {
        $value = new Value();

        self::assertSame($value->date, $this->type->getEmptyValue()->date);
    }

    public function testGetName(): void
    {
        $spiValue = new Value();

        self::assertSame((string) $spiValue, $this->type->getName($spiValue, new FieldDefinition(), 'eng-GB'));
    }

    public function testToHash(): void
    {
        $spiValue = new Value();

        self::assertSame((string) $spiValue, $this->type->toHash($spiValue));
    }

    public function testFromHash(): void
    {
        $dt = new DateTimeImmutable();
        $spiValue = new Value($dt);

        self::assertSame((string) $spiValue, (string) $this->type->fromHash($dt));
    }

    public function testFromHashWithEmptyHash(): void
    {
        $spiValue = new Value();

        self::assertSame((string) $spiValue, (string) $this->type->fromHash(''));
    }

    public function testValidateFieldSettingWithFieldSettingAsString(): void
    {
        $validationError = new ValidationError('Field settings must be in form of an array');

        $errors = $this->type->validateFieldSettings('test');

        self::assertSame($validationError->getTarget(), $errors[0]->getTarget());
        self::assertSame((string) $validationError->getTranslatableMessage(), (string) $errors[0]->getTranslatableMessage());
    }

    public function testValidateFieldSettingsWithUnknownSetting(): void
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

        self::assertSame($validationError->getTarget(), $errors[0]->getTarget());
        self::assertSame((string) $validationError->getTranslatableMessage(), (string) $errors[0]->getTranslatableMessage());
    }

    public function testValidateFieldSettingsWithInvalidDefaultValue(): void
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

        self::assertSame($validationError->getTarget(), $errors[0]->getTarget());
        self::assertSame((string) $validationError->getTranslatableMessage(), (string) $errors[0]->getTranslatableMessage());
    }

    public function testValidateFieldSettings(): void
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

        self::assertSame($validationError->getTarget(), $errors[0]->getTarget());
        self::assertSame((string) $validationError->getTranslatableMessage(), (string) $errors[0]->getTranslatableMessage());
    }

    public function testAcceptValueWithDateTimeAsInput(): void
    {
        $dt = new DateTimeImmutable();

        $this->type->acceptValue($dt);
    }

    public function testAcceptValueWithValue(): void
    {
        $dt = new DateTimeImmutable();
        $value = new Value($dt);

        $this->type->acceptValue($value);
    }

    public function testAcceptValueWithInvalidValue(): void
    {
        $this->expectException(InvalidArgumentType::class);
        $this->expectExceptionMessage("Argument '\$value->date' is invalid: value must be of type 'DateTime', not 'string'");

        $value = new Value();
        $value->date = 'test';

        $this->type->acceptValue($value);
    }

    public function testToPersistenceValue(): void
    {
        $value = new Value(new DateTimeImmutable());

        $this->type->toPersistenceValue($value);
    }
}
