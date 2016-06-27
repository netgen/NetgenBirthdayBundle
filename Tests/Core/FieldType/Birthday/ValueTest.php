<?php

namespace Netgen\Bundle\BirthdayBundle\Tests\Core\FieldType\Birthday;

use Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value;
use eZ\Publish\Core\FieldType\Value as BaseValue;
use PHPUnit\Framework\TestCase;

class ValueTest extends TestCase
{
    public function testInstanceOfValue()
    {
        $this->assertInstanceOf(BaseValue::class, new Value());
    }
}
