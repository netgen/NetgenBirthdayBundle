<?php

declare(strict_types=1);

namespace Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday;

use DateTimeImmutable;
use DateTimeInterface;
use eZ\Publish\Core\FieldType\Value as BaseValue;
use function is_string;

final class Value extends BaseValue
{
    /**
     * @var \DateTimeImmutable
     */
    public $date;

    /**
     * Date format to be used by {@link __toString()}.
     *
     * @var string
     */
    private $dateFormat = 'Y-m-d';

    /**
     * Construct a new Value object and initialize with $dateTime.
     *
     * @param \DateTimeInterface|string|null $date Date as a DateTime object or string in Y-m-d format
     */
    public function __construct($date = null)
    {
        if ($date instanceof DateTimeImmutable) {
            $this->date = $date->setTime(0, 0);
        } elseif (is_string($date)) {
            $this->date = new DateTimeImmutable($date);
        }
    }

    public function __toString(): string
    {
        if (!$this->date instanceof DateTimeInterface) {
            return '';
        }

        return $this->date->format($this->dateFormat);
    }
}
