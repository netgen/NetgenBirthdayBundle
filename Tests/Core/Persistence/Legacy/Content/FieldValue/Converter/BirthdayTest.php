<?php

namespace Netgen\Bundle\BirthdayBundle\Tests\Core\Persistence\Legacy\Content\FieldValue\Converter;

use eZ\Publish\Core\Persistence\Legacy\Content\FieldValue\Converter;
use Netgen\Bundle\BirthdayBundle\Core\Persistence\Legacy\Content\FieldValue\Converter\Birthday;
use PHPUnit\Framework\TestCase;

class BirthdayTest extends TestCase
{
    /**
     * @var Birthday
     */
    private $converter;

    public function setUp()
    {
        $this->converter = new Birthday();
    }

    public function testInstanceOfConverter()
    {
        $this->assertInstanceOf(Converter::class, $this->converter);
    }
}
