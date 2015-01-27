<?php

class eZDataTableAuditLog extends eZDataTableBase implements eZDataTableInterface
{
	public static function definition()
	{
		$baseURI = '/';
		eZURI::transformURI( $baseURI );

		return array(
			'columns' => array(
				array( 'key' => 'action', 'label' => ezpI18n::tr( 'dms/helper/php', 'Action'), 'parser' => 'string', 'sortable' => false, 'hidden' => false, 'formatter' => 'text' ),
				array( 'key' => 'timestamp', 'label' => ezpI18n::tr( 'dms/helper/php', 'Time'), 'parser' => 'timestamp', 'sortable' => false, 'hidden' => false, 'formatter' => 'date' ),
				array( 'key' => 'ip_address', 'label' => ezpI18n::tr( 'dms/helper/php', 'IP address'), 'parser' => 'string', 'sortable' => false, 'hidden' => false, 'formatter' => 'text' ),
				array( 'key' => 'user_login', 'label' => ezpI18n::tr( 'dms/helper/php', 'User login'), 'parser' => 'string', 'sortable' => false, 'hidden' => false, 'formatter' => 'text' ),
				array( 'key' => 'details', 'label' => ezpI18n::tr( 'dms/helper/php', 'Details'), 'parser' => 'string', 'sortable' => false, 'hidden' => false, 'formatter' => 'text' )
			),
			'date_format' => '%d.%m.%Y %H:%M:%S',
			'base_uri' => $baseURI
		);
	}

	public function getTableData()
	{
		$returnArray = array( 'count' => 0, 'offset' => $this->Offset, 'data' => array() );

		if ( !isset( $this->DataTableParams['object_id'] ) )
			return $returnArray;

		$objectID = (int) $this->DataTableParams['object_id'];

		$data = array();

		$auditEntries = eZDBAudit::fetchByObjectID( $objectID, null, $this->Offset, $this->Limit );
		$entriesCount = (int) eZDBAudit::fetchCountByObjectID( $objectID );

		if ( is_array( $auditEntries ) )
		{
			foreach ( $auditEntries as $auditEntry )
			{
				$entryArray = array();
				$entryArray['action'] = $auditEntry->attribute( 'action' );
				$entryArray['timestamp'] = (int) $auditEntry->attribute( 'timestamp' );
				$entryArray['ip_address'] = $auditEntry->attribute( 'ip_address' );
				$entryArray['user_login'] = $auditEntry->attribute( 'user_login' );
				$entryArray['details'] = $auditEntry->attribute( 'details' );
				$data[] = $entryArray;
			}
		}

		$returnArray['count'] = $entriesCount;
		$returnArray['data'] = $data;
		return $returnArray;
	}
}

?>
