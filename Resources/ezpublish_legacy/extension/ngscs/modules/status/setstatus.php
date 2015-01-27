<?php

$Module = $Params['Module'];

if ( $Module->hasActionParameter( 'NodeIDList' ) and
     $Module->hasActionParameter( 'SectionID' ) )
{
    $nodeIDList = $Module->actionParameter( 'NodeIDList' );
    $sectionID = $Module->actionParameter( 'SectionID' );
}
else
    $Module->hasActionParameter( 'RedirectRelativeURI' ) ? $Module->redirectTo( $Module->actionParameter( 'RedirectRelativeURI' ) ) : $Module->redirectTo( '/' );

$selectedSection = eZSection::fetch( $sectionID );

if ( $selectedSection instanceof eZSection )
{
    $currentUser = eZUser::currentUser();

    foreach($nodeIDList as $nodeID)
    {
        $node = eZContentObjectTreeNode::fetch($nodeID);
        if ( $node instanceof eZContentObjectTreeNode )
        {
            $object = $node->attribute( 'object' );
            if ( $object instanceof eZContentObject )
            {
                $currentSectionID = (int) $object->attribute( 'section_id' );

                if ( $currentUser instanceof eZUser && $currentUser->canAssignSectionToObject( $sectionID, $object ) && $currentSectionID != $sectionID )
                {
                    $db = eZDB::instance();
                    $db->begin();

                    eZContentObjectTreeNode::assignSectionToSubTree( $nodeID, $sectionID );
                    eZContentOperationCollection::registerSearchObject( $object->attribute( 'id' ), $object->attribute( 'current_version' ) );
                    eZContentObjectTreeNode::clearViewCacheForSubtree( $node );

                    $currentSectionName = $currentSectionID;
                    $currentSection = eZSection::fetch( $currentSectionID );
                    if ( $currentSection instanceof eZSection )
                        $currentSectionName = $currentSection->attribute( 'name' );

                    eZAudit::writeAuditToDatabase(
                        'status-change',
                        array(
                            'Source' => $currentSectionName,
                            'Target' => $selectedSection->attribute( 'name' )
                        ),
                        $object->attribute( 'id' )
                    );
                    
                    $db->commit();
                }
            }
        }
    }
}

$Module->hasActionParameter( 'RedirectRelativeURI' ) ? $Module->redirectTo( $Module->actionParameter( 'RedirectRelativeURI' ) ) : $Module->redirectTo( '/' );

?>
