<?php

namespace Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday;

use eZ\Publish\Core\FieldType\Value as BaseValue;
use DateTime;

class Value extends BaseValue
{
    /**
     * @var \DateTime
     */
    public $date = null;

    /**
     * Date format to be used by {@link __toString()}.
     *
     * @var string
     */
    protected $dateFormat = 'Y-m-d';

    /**
     * Construct a new Value object and initialize with $dateTime.
     *
     * @param \DateTime|string|null $date Date as a DateTime object or string in Y-m-d format
     */
    public function __construct($date = null)
    {
        if ($date instanceof DateTime) {
            $date = clone $date;
            $date->setTime(0, 0, 0);

            $this->date = $date;
        } elseif (is_string($date)) {
            $this->date = new DateTime($date);
        }
    }

    /**
     * Returns a string representation of the field value.
     *
     * @return string
     */
    public function __toString()
    {
        if (!$this->date instanceof DateTime) {
            return '';
        }

        return $this->date->format($this->dateFormat);
    }
}
