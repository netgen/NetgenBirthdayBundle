<?php

class eZDataTableBase
{
	protected $ElementID = null;
	protected $Offset = false;
	protected $Limit = 10;
	protected $SortBy = null;
	protected $SortDirection = true;

	protected $DataTableParams = array();

	public function __construct()
	{
		$http = eZHTTPTool::instance();

		if ( $http->hasGetVariable( 'element' ) )
		{
			$this->ElementID = trim( $http->getVariable( 'element' ) );
		}

		if ( $http->hasGetVariable( 'offset' ) )
		{
			$this->Offset = (int) $http->getVariable( 'offset' );

			if ( $http->hasGetVariable( 'limit' ) )
				$this->Limit = (int) $http->getVariable( 'limit' );
		}
		else
		{
			$this->Limit = false;
		}

		if ( $http->hasGetVariable( 'sortby' ) )
		{
			$this->SortBy = trim( $http->getVariable( 'sortby' ) );

			if ( $http->hasGetVariable( 'sortdirection' ) && trim( $http->getVariable( 'sortdirection' ) ) == 'desc' )
				$this->SortDirection = false;
		}

		if ( $http->hasGetVariable( 'dataTableParams' ) )
		{
			$dataTableParams = explode( ':', $http->getVariable( 'dataTableParams' ) );
			if ( is_array( $dataTableParams ) && !empty( $dataTableParams ) && count( $dataTableParams ) % 2 == 0 )
			{
				for ( $i = 0; $i < count( $dataTableParams ); $i += 2 )
				{
					$this->DataTableParams[$dataTableParams[$i]] = $dataTableParams[$i + 1];
				}
			}
		}
	}

}

?>