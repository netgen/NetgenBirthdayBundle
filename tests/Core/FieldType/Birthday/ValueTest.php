<?php

declare(strict_types=1);

namespace Netgen\Bundle\BirthdayBundle\Tests\Core\FieldType\Birthday;

use DateTimeImmutable;
use eZ\Publish\Core\FieldType\Value as BaseValue;
use Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value;
use PHPUnit\Framework\TestCase;

class ValueTest extends TestCase
{
    public function testInstanceOfValue()
    {
        self::assertInstanceOf(BaseValue::class, new Value());
    }

    public function testConstructWithDateTime()
    {
        $dt = new DateTimeImmutable();

        $value = new Value($dt);

        self::assertSame($dt->format('Y-m-d'), (string) $value);
    }

    public function testConstructWithString()
    {
        $str = '2014-3-30';
        $dt = new DateTimeImmutable($str);

        $value = new Value($str);

        self::assertSame($dt->format('Y-m-d'), (string) $value);
    }

    public function testConstructWithNull()
    {
        $value = new Value(null);

        self::assertSame('', (string) $value);
    }
}
