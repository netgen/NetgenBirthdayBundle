<?php

interface eZDataTableInterface
{
	public static function definition();

	public function getTableData();

    public function getResponseArray( $searchResult );
}

?>
