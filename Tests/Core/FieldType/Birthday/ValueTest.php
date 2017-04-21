<?php

namespace Netgen\Bundle\BirthdayBundle\Tests\Core\FieldType\Birthday;

use eZ\Publish\Core\FieldType\Value as BaseValue;
use Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value;

class ValueTest extends \PHPUnit_Framework_TestCase
{
    public function testInstanceOfValue()
    {
        $this->assertInstanceOf(BaseValue::class, new Value());
    }

    public function testConstructWithDateTime()
    {
        $dt = new \DateTime();

        $value = new Value($dt);

        $this->assertEquals($dt->format('Y-m-d'), (string) $value);
    }

    public function testConstructWithString()
    {
        $str = '2014-3-30';
        $dt = new \DateTime($str);

        $value = new Value($str);

        $this->assertEquals($dt->format('Y-m-d'), (string) $value);
    }

    public function testConstructWithNull()
    {
        $value = new Value(null);

        $this->assertEquals('', (string) $value);
    }
}
