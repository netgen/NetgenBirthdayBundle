<?php

namespace Netgen\Bundle\BirthdayBundle\Tests\Core\FieldType\Birthday;

use eZ\Publish\SPI\FieldType\FieldType;
use Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Type;
use PHPUnit\Framework\TestCase;

class TypeTest extends TestCase
{
    private $type;

    public function setUp()
    {
        $this->type = new Type();
    }

    public function testInstanceOfFieldType()
    {
        $this->assertInstanceOf(FieldType::class, $this->type);
    }
}
