<?php

$ini = eZINI::instance('dms.ini');

$initSection = $ini->variable('DMSSettings', 'InitSection');

$Module = $Params['Module'];
$objectID = $Params['ObjectID'];
$userParams = $Params['UserParameters'];

$object = eZContentObject::fetch($objectID);
if ( is_object( $object )) {
    $mainNodeID = $object->attribute( 'main_node_id' );
    eZContentObjectTreeNode::assignSectionToSubTree( $mainNodeID, $initSection );
    
    $userParamsString = '';
    if ( count( $userParams ) > 0 ) {
        foreach( $userParams as $key => $value ) {
			if ($key == 'fragment') {
                $userParamsString = $userParamsString . '#fragment-' . $value;
			} else {
	            $userParamsString = $userParamsString . '/'. '(' . $key . ')' . '/' . $value ;
			}
        }
    }

    return $Module->redirectTo( '/content/view/full/' . $mainNodeID . '/' . $userParamsString);
}

return $Module->redirectTo( '/' );

?>
