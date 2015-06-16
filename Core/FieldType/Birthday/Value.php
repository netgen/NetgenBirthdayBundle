<?php

namespace Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday;

use eZ\Publish\Core\FieldType\Value as BaseValue;

class Value extends BaseValue
{
    /**
     * @var string
     */
    public $year;

    /**
     * @var string
     */
    public $month;

    /**
     * @var string
     */
    public $day;

    /**
     * @var string
     */
    public $date;

    /**
     * Constructor
     *
     * @param string $date
     */
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

    /**
     * Returns a string representation of the field value.
     *
     * @return string
     */
    public function __toString()
    {
        if ( empty( $this->date ) )
        {
            return '';
        }

        return sprintf( "%04d", $this->year ) . '-' . sprintf( "%02d", $this->month ) . '-' . sprintf( "%02d", $this->day );
    }
}
