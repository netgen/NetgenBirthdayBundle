<?php

class ezjscNgRgm
{
	public static function deleteFileObject( $args )
	{
		if ( !is_array( $args ) || empty( $args ) )
			return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Invalid parameters sent!' ) );

		$object = eZContentObject::fetch( (int) $args[0] );
		if ( !$object instanceof eZContentObject )
			return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Error removing file! Invalid object with ID %id!', '', array( '%id' =>  $args[0] ) ) );

		if ( !$object->canRemove() )
			return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Error removing file! Permission denied!' ) );

		$mainNodeID = $object->mainNode()->attribute( 'node_id' );
		if ( eZOperationHandler::operationIsAvailable( 'content_delete' ) )
		{
			$operationResult = eZOperationHandler::execute( 'content',
															'delete',
															 array( 'node_id_list' => array( $mainNodeID ),
																	'move_to_trash' => false ),
															  null, true );

			if ( isset( $operationResult['status'] ) && $operationResult['status'] == eZModuleOperationInfo::STATUS_CONTINUE )
				return array( 'status' => 'success', 'message' => ezpI18n::tr( 'dms/helper/php', 'Successfully removed file!' ) );
			else
				return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Error removing file! Unspecified error!' ) );
		}
		else
		{
			eZContentOperationCollection::deleteObject( array( $mainNodeID ), false );
			return array( 'status' => 'success', 'message' => ezpI18n::tr( 'dms/helper/php', 'Successfully removed file!' ) );
		}
	}

	public static function deleteObject( $args )
	{
		if ( !is_array( $args ) || empty( $args ) )
			return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Invalid parameters sent!' ) );

		$object = eZContentObject::fetch( (int) $args[0] );
		if ( !$object instanceof eZContentObject )
			return array( 'status' => 'error', 'message' =>  ezpI18n::tr( 'dms/helper/php', 'Error removing dossier! Invalid object with ID %id!', '', array( '%id' =>  $args[0] ) ) );

		$dossierSerial = '0';
		$dossierSerialAttr = $object->fetchAttributesByIdentifier( array( 'id' ) );
		if ( is_array( $dossierSerialAttr ) && !empty( $dossierSerialAttr ) )
		{
			$arrayKeys = array_keys( $dossierSerialAttr );
			$dossierSerial = $dossierSerialAttr[$arrayKeys[0]]->hasContent() ? $dossierSerialAttr[$arrayKeys[0]]->content() : '0';
		}

		$dossierSerial = str_pad( $dossierSerial, 6, '0', STR_PAD_LEFT );

		if ( !$object->canRemove() )
			return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Error removing dossier %dossier_serial! Permission denied!', '', array( '%dossier_serial' =>  $dossierSerial ) ) );

		$mainNodeID = $object->mainNode()->attribute( 'node_id' );
		if ( eZOperationHandler::operationIsAvailable( 'content_delete' ) )
		{
			$operationResult = eZOperationHandler::execute( 'content',
															'delete',
															 array( 'node_id_list' => array( $mainNodeID ),
																	'move_to_trash' => true ),
															  null, true );

			if ( isset( $operationResult['status'] ) && $operationResult['status'] == eZModuleOperationInfo::STATUS_CONTINUE )
				return array( 'status' => 'success', 'message' => ezpI18n::tr( 'dms/helper/php', 'Successfully removed dossier %dossier_serial!', '', array( '%dossier_serial' =>  $dossierSerial ) ) );
			else
				return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Error removing dossier %dossier_serial! Unspecified error!', '', array( '%dossier_serial' =>  $dossierSerial ) ) );
		}
		else
		{
			eZContentOperationCollection::deleteObject( array( $mainNodeID ), false );
			return array( 'status' => 'success', 'message' => ezpI18n::tr( 'dms/helper/php', 'Successfully removed dossier %dossier_serial!', '', array( '%dossier_serial' =>  $dossierSerial ) ) );
		}
	}

	function changeObjectSection( $args )
	{
		if ( !is_array( $args ) || count( $args ) < 2 )
			return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Invalid parameters sent!' ) );

		$object = eZContentObject::fetch( (int) $args[0] );
		if ( !$object instanceof eZContentObject )
			return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Error changing dossier status! Invalid object with ID %id!', '', array( '%id' =>  $args[0] ) ) );

		$newSectionID = (int) $args[1];
		$newSection = eZSection::fetch( $newSectionID );
		if ( !$newSection instanceof eZSection )
			return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Error changing dossier status! Invalid section ID selected!' ) );

		$allowedSectionIDs = array();
		$allowedSections = $object->allowedAssignSectionList();
		if ( is_array( $allowedSections ) )
		{
			foreach ( $allowedSections as $section )
			{
				if ( is_array( $section ) && isset( $section['id'] ) && is_numeric( $section['id'] ) )
					$allowedSectionIDs[] = (int) $section['id'];
			}
		}

		$dossierSerial = '0';
		$dossierSerialAttr = $object->fetchAttributesByIdentifier( array( 'id' ) );
		if ( is_array( $dossierSerialAttr ) && !empty( $dossierSerialAttr ) )
		{
			$arrayKeys = array_keys( $dossierSerialAttr );
			$dossierSerial = $dossierSerialAttr[$arrayKeys[0]]->hasContent() ? $dossierSerialAttr[$arrayKeys[0]]->content() : '0';
		}

		if ($dossierSerial == '0')
		{
			$numberAttr = $object->fetchAttributesByIdentifier( array('number') );
				$arrayKeys = array_keys( $numberAttr );
				$dossierSerial = $numberAttr[$arrayKeys[0]]->hasContent() ? $numberAttr[$arrayKeys[0]]->content() : '0';
		}

		if ( !in_array( $newSectionID, $allowedSectionIDs ) )
			return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Error changing status of dossier %dossier_serial! Permission denied!', '', array( '%dossier_serial' =>  $dossierSerial ) ) );

		$currentSectionID = (int) $object->attribute( 'section_id' );
		if ( $currentSectionID == $newSectionID )
			return array( 'status' => 'warning', 'message' => ezpI18n::tr( 'dms/helper/php', 'Status of dossier %dossier_serial not changed! Original and new status are the same!', '', array( '%dossier_serial' =>  $dossierSerial ) ) );

		$currentSectionName = $currentSectionID;
		$currentSection = eZSection::fetch( $currentSectionID );
		if ( $currentSection instanceof eZSection )
			$currentSectionName = $currentSection->attribute( 'name' );

		$mainNode = $object->mainNode();
		if ( !$mainNode instanceof eZContentObjectTreeNode )
			return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Error changing status of dossier %dossier_serial! Dossier is invalid!', '', array( '%dossier_serial' =>  $dossierSerial ) ) );

		$db = eZDB::instance();
		$db->begin();

		eZContentObjectTreeNode::assignSectionToSubTree( $mainNode->attribute( 'node_id' ), $newSectionID, $currentSectionID );

		$dossierInvalidDateAttr = $object->fetchAttributesByIdentifier( array( 'invalidity_date' ) );
		if ( is_array( $dossierInvalidDateAttr ) && !empty( $dossierInvalidDateAttr ) )
		{
			$dossierInvalidDateAttr = array_values( $dossierInvalidDateAttr );
			if ( $dossierInvalidDateAttr[0]->hasContent() )
			{
				$dossierInvalidTimestamp = (int) $dossierInvalidDateAttr[0]->content()->attribute('timestamp');
				if ( $dossierInvalidTimestamp > 0 && $dossierInvalidTimestamp < time() )
				{
					$dossierInvalidAttr = $object->fetchAttributesByIdentifier( array( 'invalid' ) );
					if ( is_array( $dossierInvalidAttr ) && !empty( $dossierInvalidAttr ) )
					{
						$dossierInvalidAttr = array_values( $dossierInvalidAttr );
						$dossierInvalidAttr[0]->setAttribute( 'data_int', 1 );
						$dossierInvalidAttr[0]->store();
					}
				}
			}
		}

		eZContentOperationCollection::registerSearchObject( $object->attribute( 'id' ), $object->attribute( 'current_version' ) );
		eZContentObjectTreeNode::clearViewCacheForSubtree( $mainNode );

		eZAudit::writeAuditToDatabase(
			'status-change',
			array(
				ezpI18n::tr( 'dms/helper/php','Source') => ezpI18n::tr( 'dms/helper/php', $currentSectionName),
				ezpI18n::tr( 'dms/helper/php','Target') => ezpI18n::tr( 'dms/helper/php', $newSection->attribute( 'name' ))
			),
			$object->attribute( 'id' )
		);

		if ( $object->attribute( 'class_identifier' ) == 'dossier_ld' ) {
			// if new section is public and validity date is set for dossier,
			// invalidate any "invalidated_dossiers" at the date
			// new object becomes valid
			if ( $newSectionID == 7 )
			{
				$validDateAttr = $object->fetchAttributesByIdentifier( array( 'validity_date','effective_on' ) );
				$invalidatedDossiersAttr = $object->fetchAttributesByIdentifier( array( 'invalidated_dossiers' ) );
				if ( is_array( $validDateAttr ) && !empty( $validDateAttr ) && is_array( $invalidatedDossiersAttr ) && !empty( $invalidatedDossiersAttr ) )
				{
					$arrayKeys = array_keys( $validDateAttr );
					$validDateAttr = $validDateAttr[$arrayKeys[0]];

					$arrayKeys = array_keys( $invalidatedDossiersAttr );
					$invalidatedDossiersAttr = $invalidatedDossiersAttr[$arrayKeys[0]];

					if ( $validDateAttr->hasContent() && $invalidatedDossiersAttr->hasContent() )
					{
						if ($validDateAttr->attribute('data_type_string') == 'ezdate') {
							$validityDate = $validDateAttr->attribute( 'data_int' );
						} else if ($validDateAttr->attribute('data_type_string') == 'ezbirthday') {
							$validDateContent = $validDateAttr->content();
							$validityDate = mktime(0,0,0,$validDateContent->attribute( 'month' ), $validDateContent->attribute( 'day' ), $validDateContent->attribute( 'year' ));
						}
						if ($validityDate > 0) {
							$dossiersToInvalidate = $invalidatedDossiersAttr->content();
							foreach ( $dossiersToInvalidate['relation_browse'] as $relationItem )
							{
								$relationItemObject = eZContentObject::fetch( $relationItem['contentobject_id'] );
								if ( $relationItemObject instanceof eZContentObject )
								{
									$invalidDateAttr = $relationItemObject->fetchAttributesByIdentifier( array( 'invalidity_date' ) );
									if ( is_array( $invalidDateAttr ) && !empty( $invalidDateAttr ) )
									{
										$arrayKeys = array_keys( $invalidDateAttr );
										$invalidDateAttr = $invalidDateAttr[$arrayKeys[0]];

										$invalidDateAttr->setAttribute( 'data_int', $validityDate );
										$invalidDateAttr->store();

										eZContentCacheManager::clearObjectViewCache( $relationItemObject->attribute( 'id' ) );
									}
								}
							}
						}
					}
				}
			}

			if ($newSectionID == 8) {
				$parentNodeID = $mainNode->attribute( 'parent_node_id' );
				$groups = $db->arrayQuery( "select contentobject_id from ezuser_role where limit_value like '%/". $parentNodeID ."/%' and role_id = 48");
				if ( is_array( $groups ) && count( $groups ) != 0 ) {
					$params = array(
						'subject' => "Proceed with change",
						'content' => 'status change to "private"',
						'recipient_group' => $groups[0]['contentobject_id'],
						'related_node_id' => $mainNode->attribute( 'node_id' ) );
				}
			} else if ($newSectionID == 10 && $currentSectionID == 8) {
				$ini = eZINI::instance( 'site.ini' );
				$params = array(
					'subject' => "Changes done",
					'content' => 'status change to "official"',
					'related_node_id' => $mainNode->attribute( 'node_id' ) );
				$recipients = GetRecipients::get_recipients( $ini->variable('NetgenSettings','MessageReceiveRole'), $mainNode->attribute( 'parent_node_id' ) );
				if ($recipients['groups'] != '')
					$params['recipient_group'] = $recipients['groups'];
				if ($recipients['users'] != '')
					$params['recipient_id'] = $recipients['users'];
				if ($recipients == false)
					$params['recipient_group'] = $ini->variable('NetgenSettings','ACPAGroup');
			}

			if (is_array($params))
				$sendMessage = ngPM::createGroupMessage($params );
		}

		$db->commit();

		return array( 'status' => 'success', 'message' => ezpI18n::tr( 'dms/helper/php', 'Successfully changed status of dossier %dossier_serial!', '', array( '%dossier_serial' =>  $dossierSerial ) ) );
	}
	/**
	 * Special feture mvoe object and regenerate new
	 * @param  [type] $args [description]
	 * @return [type]       [description]
	 */
	function moveObjectsSpecial( $args )
	{
		$objectID = $args[0];
		$newParentNodeID = $args[1];

		$newParentNode = eZContentObjectTreeNode::fetch( $newParentNodeID );

		if ( !$newParentNode )
            return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Agency not available.') );

        $objectForMove = eZContentObject::fetch( $objectID );

        if ( !$objectForMove instanceof eZContentObject )
        	return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Dossier not available.') );

        $nodeForMove = $objectForMove->mainNode();

        if ( !$nodeForMove )
            return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Agency not available.') );

        if ( !$nodeForMove->canMoveFrom() )
            return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', "Access denied. You don't have access to move this dossier.") );

		$objectForMove = $nodeForMove->object();
        if ( !$objectForMove )
            return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Dossier not available.') );

        $class = $objectForMove->contentClass();
        $classID = $class->attribute( 'id' );

        // check if the object can be moved to (under) the selected node
        if ( !$newParentNode->canMoveTo( $classID ) )
        {
            eZDebug::writeError( "Cannot move node dossier as child of parent node ". $newParentNode->attribute('name') .", the current user does not have create permission for class ID $classID",
                                 'ezjscore->moveObjectsSpecial' );
            return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', "Cannot move node %node_id as child of parent node %parent_node_name, the current user does not have create permission for class ID %class_id.", '', array( '%node_id' => $nodeID, '%parent_node_name' => $newParentNode->attribute('name'), '%class_id' => $classID ) ) );
        }

        // Check if we try to move the node as child of itself or one of its children
        if ( in_array( $nodeForMove->attribute( 'node_id' ), $newParentNode->pathArray()  ) )
        {
            // ovo se ne bi trebalo dogoditi
            eZDebug::writeError( ezpI18n::tr( 'dms/helper/php', "Cannot move dossier as child of itself or one of its own children (%parent_node_name)", '', array('%parent_node_name' => $newParentNode->attribute('name') ) ),
                                 'ezjscore->moveObjectsSpecial' );
            return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', "Cannot move node dossier as child of itself or one of its own children (%parent_node_name)", '', array('%parent_node_name' => $newParentNode->attribute('name') ) ) );
        }

        $nodeToMoveArray = array( 'node_id'   => $nodeForMove->attribute( 'node_id' ),
                                  'object_id' => $objectID );

        // Setup the attribute related_agency content

        $newParentNodeDataMap = $newParentNode->attribute('data_map');
        $parentAgencyAttribute = $newParentNodeDataMap['related_agency'];

        $objectForMoveDataMap = $objectForMove->attribute('data_map');
        $objectIssuingAgencyAttribute = $objectForMoveDataMap['issuing_agency'];

		$objectIssuingAgencyAttribute->setContent( $parentAgencyAttribute->content() );
		$objectIssuingAgencyAttribute->setAttribute( 'data_int', $parentAgencyAttribute->attribute('data_int') );
		$objectIssuingAgencyAttribute->store();

		// Setup the attribute id content
		$timestamp = $objectForMove->attribute('published');
		//$parentNode = eZContentObjectTreeNode::fetch( $objectForMove->attribute('main_node')->attribute('parent_node_id') );
		$parentPrefix = $newParentNodeDataMap['prefix']->content();
		$objectIDAttribute = $objectForMoveDataMap['id'];

		$objectIDAttribute->setContent( $parentPrefix . date( 'dmYHis', $timestamp) );
		$objectIDAttribute->setAttribute('data_text', $parentPrefix . date( 'dmYHis', $timestamp) );
		$objectIDAttribute->store();

		//set the new name of object
		$class = $objectForMove->contentClass();
        $objectForMove->setName( $class->contentObjectName( $objectForMove ) );
        $objectForMove->store();

        eZContentObject::clearCache( array( $objectID ) );

        if ( eZOperationHandler::operationIsAvailable( 'content_move' ) )
        {
            $operationResult = eZOperationHandler::execute( 'content',
                                                            'move', array( 'node_id'            => $nodeToMoveArray['node_id'],
                                                                           'object_id'          => $nodeToMoveArray['object_id'],
                                                                           'new_parent_node_id' => $newParentNodeID ),
                                                            null,
                                                            true );
        }
        else
        {
            eZContentOperationCollection::moveNode( $nodeToMoveArray['node_id'], $nodeToMoveArray['object_id'], $newParentNodeID );
        }

		return array( 'status' => 'success', 'message' => ezpI18n::tr( 'dms/helper/php', 'Successfully moved dossier %dossier_name', '', array( '%dossier_name' => $objectForMove->attribute('name') ) ) );
	}

	function setToValid( $args )
	{
		if ( !is_array( $args ) || empty( $args ) )
			return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Invalid parameters sent!' ) );

		$object = eZContentObject::fetch( (int) $args[0] );
		if ( !$object instanceof eZContentObject )
			return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Error setting to Valid! Invalid object with ID %id', '', array( '%id' => $args[0] ) ) );

		$dossierSerial = '0';
		$dossierSerialAttr = $object->fetchAttributesByIdentifier( array( 'id' ) );
		if ( is_array( $dossierSerialAttr ) && !empty( $dossierSerialAttr ) )
		{
			$arrayKeys = array_keys( $dossierSerialAttr );
			$dossierSerial = $dossierSerialAttr[$arrayKeys[0]]->hasContent() ? $dossierSerialAttr[$arrayKeys[0]]->content() : '0';
		}

		$dossierSerial = str_pad( $dossierSerial, 6, '0', STR_PAD_LEFT );

		if ( !$object->canEdit() )
			return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Error setting to Valid %dossier_serial! Permission denied!', '', array( '%dossier_serial' => $dossierSerial ) ) );

		$isValidAttr = $object->fetchAttributesByIdentifier( array( 'validity' ) );

		if ( is_array( $isValidAttr ) && !empty( $isValidAttr ) )
		{
			$arrayKeys = array_keys( $isValidAttr );
			$isValidAttr = $isValidAttr[$arrayKeys[0]];
			if ( $isValidAttr instanceof eZContentObjectAttribute )
			{
				$isValid = $isValidAttr->content();
			}
		}

		if ($isValid)
			return array( 'status' => 'warning', 'message' => ezpI18n::tr( 'dms/helper/php', 'Cannot set %dossier_serial! It is already Valid!', '', array('%dossier_serial' => $dossierSerial ) ) );

		$isValidAttr->setAttribute( 'data_int', 1 );
		$isValidAttr->store();
		eZContentObjectTreeNode::clearViewCacheForSubtree( $object->mainNode() );
		eZContentOperationCollection::registerSearchObject( $object->attribute( 'id' ), $object->attribute( 'current_version' ) );

		return array( 'status' => 'success', 'message' => ezpI18n::tr( 'dms/helper/php', '%dossier_serial is set to Valid', '', array( '%dossier_serial' => $dossierSerial ) ) );
	}

	function setToInvalid( $args )
		{
		if ( !is_array( $args ) || empty( $args ) )
			return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Invalid parameters sent!' ) );

		$object = eZContentObject::fetch( (int) $args[0] );
		if ( !$object instanceof eZContentObject )
			return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Error setting to invalid! Invalid object with ID %id!', '', array( '%id' => $args[0] ) ) );

		$dossierSerial = '0';
		$dossierSerialAttr = $object->fetchAttributesByIdentifier( array( 'id' ) );
		if ( is_array( $dossierSerialAttr ) && !empty( $dossierSerialAttr ) )
		{
			$arrayKeys = array_keys( $dossierSerialAttr );
			$dossierSerial = $dossierSerialAttr[$arrayKeys[0]]->hasContent() ? $dossierSerialAttr[$arrayKeys[0]]->content() : '0';
		}

		$dossierSerial = str_pad( $dossierSerial, 6, '0', STR_PAD_LEFT );

		if ( !$object->canEdit() )
			return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Error setting to Invalid %dossier_serial! Permission denied!', '', array( '%dossier_serial' => $dossierSerial ) ) );

		$isValidAttr = $object->fetchAttributesByIdentifier( array( 'validity' ) );

		if ( is_array( $isValidAttr ) && !empty( $isValidAttr ) )
		{
			$arrayKeys = array_keys( $isValidAttr );
			$isValidAttr = $isValidAttr[$arrayKeys[0]];
			if ( $isValidAttr instanceof eZContentObjectAttribute )
			{
				$isValid = $isValidAttr->content();
			}
		}

		if (!$isValid)
			return array( 'status' => 'warning', 'message' => ezpI18n::tr( 'dms/helper/php', 'Cannot set %dossier_serial! It is already Invalid!', '', array( '%dossier_serial' => $dossierSerial ) ) );

		$isValidAttr->setAttribute( 'data_int', 0 );
		$isValidAttr->store();
		eZContentObjectTreeNode::clearViewCacheForSubtree( $object->mainNode() );
		eZContentOperationCollection::registerSearchObject( $object->attribute( 'id' ), $object->attribute( 'current_version' ) );

		return array( 'status' => 'success', 'message' => ezpI18n::tr( 'dms/helper/php', '%dossier_serial is set to Invalid', '', array( '%dossier_serial' => $dossierSerial ) ) );
	}
	function fillSelect( $args )
	{

		if (is_numeric($args[0]))
			$object = eZTagsObject::fetch((int) $args[0]);
		else
			$object = eZTagsObject::fetchByKeyword($args[0]);
		if (is_array($object))
			$object = $object[0];
		if ($object instanceof eZTagsObject)
			$children = $object->getChildren();
		$return_array = array();
		foreach ($children as $child_key => $child_value)
		{
			$return_array[$child_key] = array( 'id' => $child_value->attribute('id'), 'keyword' => $child_value->attribute('keyword') );
		}
		return $return_array;
	}

	function numberInGenerateQueue( $args )
	{
		if ( !is_array( $args ) || empty( $args ) )
			return array( 'status' => 'error', 'message' => ezpI18n::tr( 'dms/helper/php', 'Invalid parameters sent!' ) );

		$resultArray = array(
			"requests" => array(),
			"approved" => array()
		);
		$objectID = (int) $args[0];

		$db = eZDB::instance();
		$rows = $db->arrayQuery( "SELECT param, action FROM ezpending_actions WHERE param LIKE '{$objectID}:%'" );
		$nodes_request = array();
		$nodes_approved = array();
		foreach ( $rows as $row )
		{
			$objectNode = explode( ':', $row['param'] );
			if ( $row['action'] === 'generate_copy_request' )
			{
				$nodes_request[] = $objectNode[1];
			}
			elseif ( $row['action'] === 'generate_copy_approved' )
			{
				$nodes_approved[] = $objectNode[1];
			}
		}
		$resultArray["requests"]["num"] = count( $nodes_request );
		$resultArray["requests"]["nodes"] = $nodes_request;
		$resultArray["approved"]["num"] = count( $nodes_approved );
		$resultArray["approved"]["nodes"] = $nodes_approved;

		return array(
			'status' => 'success',
			"result" => $resultArray
		);
	}

	function numberInDeleteQueue( $args )
	{
		if ( !is_array( $args ) || empty( $args ) )
			return array( 'status' => 'error', 'message' => ezpI18n::tr( 'Invalid parameters sent!' ) );

		$objectID = (int) $args[0];

		$db = eZDB::instance();
		$res = $db->arrayQuery( "SELECT count(*) as num FROM ezpending_actions WHERE action = 'delete_copy' AND param LIKE '".$objectID.":%'" );

		return array('status' => 'success', 'num' => $res[0]['num']);
	}


}

?>
