<?php

namespace Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday;

use eZ\Publish\Core\FieldType\Value as BaseValue;

class Value extends BaseValue
{
    public $year;

    public $month;

    public $day;

    // date string
    public $date;

    public function __construct( $date = null )
    {
        if ( !empty( $date ) )
        {
            $this->date = $date;

            $dateArray = explode( '-', $date );
            $this->year = $dateArray[0];
            $this->month = $dateArray[1];
            $this->day = $dateArray[2];
        }
    }

    public function __toString()
    {
        if ( $this->date === null )
        {
            return '';
        }

        return (string)$this->day . '-' . $this->month . '-' . $this->year;
    }
}
