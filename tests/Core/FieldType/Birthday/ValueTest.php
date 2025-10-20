<?php

declare(strict_types=1);

namespace Netgen\Bundle\BirthdayBundle\Tests\Core\FieldType\Birthday;

use DateTimeImmutable;
use Ibexa\Core\FieldType\Value as BaseValue;
use Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value;
use PHPUnit\Framework\Attributes\CoversClass;
use PHPUnit\Framework\TestCase;

#[CoversClass(Value::class)]
final class ValueTest extends TestCase
{
    public function testInstanceOfValue(): void
    {
        self::assertInstanceOf(BaseValue::class, new Value());
    }

    public function testConstructWithDateTime(): void
    {
        $dt = new DateTimeImmutable();

        $value = new Value($dt);

        self::assertSame($dt->format('Y-m-d'), (string) $value);
    }

    public function testConstructWithString(): void
    {
        $str = '2014-3-30';
        $dt = new DateTimeImmutable($str);

        $value = new Value($str);

        self::assertSame($dt->format('Y-m-d'), (string) $value);
    }

    public function testConstructWithNull(): void
    {
        $value = new Value(null);

        self::assertSame('', (string) $value);
    }
}
