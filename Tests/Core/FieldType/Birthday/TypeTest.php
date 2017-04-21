<?php

namespace Netgen\Bundle\BirthdayBundle\Tests\Core\FieldType\Birthday;

use eZ\Publish\Core\FieldType\ValidationError;
use eZ\Publish\SPI\FieldType\FieldType;
use Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Type;
use Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value;

class TypeTest extends \PHPUnit_Framework_TestCase
{
    /**
     * @var Type
     */
    protected $type;

    public function setUp()
    {
        $this->type = new Type();
    }

    public function testInstanceOfFieldType()
    {
        $this->assertInstanceOf(FieldType::class, $this->type);
    }

    public function testIsSearchable()
    {
        $this->assertTrue($this->type->isSearchable());
    }

    public function testGetFieldTypeIdentifier()
    {
        $this->assertEquals('ezbirthday', $this->type->getFieldTypeIdentifier());
    }

    public function testGetEmptyValue()
    {
        $value = new Value();

        $this->assertEquals($value, $this->type->getEmptyValue());
    }

    public function testGetName()
    {
        $spiValue = new Value();

        $this->assertEquals((string) $spiValue, $this->type->getName($spiValue));
    }

    public function testToHash()
    {
        $spiValue = new Value();

        $this->assertEquals((string) $spiValue, $this->type->toHash($spiValue));
    }

    public function testFromHash()
    {
        $dt = new \DateTime();
        $spiValue = new Value($dt);

        $this->assertEquals($spiValue, $this->type->fromHash($dt));
    }

    public function testFromHashWithEmptyHash()
    {
        $spiValue = new Value();

        $this->assertEquals($spiValue, $this->type->fromHash(''));
    }

    public function testValidateFieldSettingWithFieldSettingAsString()
    {
        $validationError = new ValidationError('Field settings must be in form of an array');

        $errors = $this->type->validateFieldSettings('test');

        $this->assertEquals($validationError, $errors[0]);
    }

    public function testValidateFieldSettingsWithUnknownSetting()
    {
        $fieldSettings = array(
            'test' => array(),
        );

        $validationError = new ValidationError(
            "Setting '%setting%' is unknown",
            null,
            array(
                'setting' => 'test',
            )
        );

        $errors = $this->type->validateFieldSettings($fieldSettings);

        $this->assertEquals($validationError, $errors[0]);
    }

    public function testValidateFieldSettingsWithInvalidDefaultValue()
    {
        $fieldSettings = array(
            'defaultValue' => false,
        );

        $validationError = new ValidationError(
            "Setting '%setting%' value must be of integer type",
            null,
            array(
                'setting' => 'defaultValue',
            )
        );

        $errors = $this->type->validateFieldSettings($fieldSettings);

        $this->assertEquals($validationError, $errors[0]);
    }

    public function testValidateFieldSettings()
    {
        $fieldSettings = array(
            'defaultValue' => 5,
        );

        $validationError = new ValidationError(
            "Setting '%setting%' value must be either Type::DEFAULT_VALUE_EMPTY or Type::DEFAULT_VALUE_CURRENT_DATE",
            null,
            array(
                'setting' => 'defaultValue',
            )
        );

        $errors = $this->type->validateFieldSettings($fieldSettings);

        $this->assertEquals($validationError, $errors[0]);
    }

    public function testAcceptValueWithDateTimeAsInput()
    {
        $dt = new \DateTime();

        $this->type->acceptValue($dt);
    }

    public function testAcceptValueWithValue()
    {
        $dt = new \DateTime();
        $value = new Value($dt);

        $this->type->acceptValue($value);
    }

    /**
     * @expectedException \eZ\Publish\Core\Base\Exceptions\InvalidArgumentType
     * @expectedExceptionMessage Argument '$value->date' is invalid: expected value to be of type 'DateTime', got 'string'
     */
    public function testAcceptValueWithInvalidValue()
    {
        $value = new Value();
        $value->date = 'test';

        $this->type->acceptValue($value);
    }

    public function testToPersistenceValue()
    {
        $value = new Value(new \DateTime());

        $this->type->toPersistenceValue($value);
    }
}
