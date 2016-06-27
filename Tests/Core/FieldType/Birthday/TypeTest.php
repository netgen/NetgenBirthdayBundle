<?php

namespace Netgen\Bundle\BirthdayBundle\Tests\Core\FieldType\Birthday;

use eZ\Publish\SPI\FieldType\FieldType;
use Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Type;
use Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value;

class TypeTest extends \PHPUnit_Framework_TestCase
{
    /**
     * @var Type
     */
    private $type;

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

        $this->assertEquals(strval($spiValue), $this->type->getName($spiValue));
    }

    public function testToHash()
    {
        $spiValue = new Value();

        $this->assertEquals(strval($spiValue), $this->type->toHash($spiValue));
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
}
