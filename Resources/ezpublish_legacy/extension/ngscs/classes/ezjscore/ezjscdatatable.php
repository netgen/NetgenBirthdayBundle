<?php

class ezjscDataTable
{
	public static function getTableData( $args )
	{
		if ( isset( $args[0] ) && strlen( trim( $args[0] ) ) > 0 )
		{
			$ini = eZINI::instance( 'ezdatatable.ini' );
			$tableName = trim( $args[0] );

			$dataTableHandlerClasses = $ini->variable( 'DataTableSettings', 'DataTableHandlerClasses' );
			if ( isset( $dataTableHandlerClasses[$tableName] ) && class_exists( $dataTableHandlerClasses[$tableName] ) )
			{
				$dataTableHandlerClassName = $dataTableHandlerClasses[$tableName];

				if ( isset( $args[1] ) && trim( $args[1] ) == 'definition' )
				{
					if ( method_exists( $dataTableHandlerClassName, 'definition' ) )
						return call_user_func( array( $dataTableHandlerClassName, 'definition' ) );
				}

				$dataTableHandler = new $dataTableHandlerClassName();
				if ( $dataTableHandler instanceof eZDataTableInterface )
					return $dataTableHandler->getTableData();
			}
		}
	}
}

?>