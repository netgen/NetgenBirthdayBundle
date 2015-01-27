<?php

    $Module =& $Params['Module'];
    $ObjectID =& $Params['ObjectID'];
    $userParams =& $Params['UserParameters'];

    include_once( 'kernel/classes/ezcontentobject.php' );

    $object = eZContentObject::fetch( $ObjectID );

    if ( $object )
    {
        $mainNodeID = $object->attribute( 'main_node_id' );

        $userParamsString = '';

        if ( count( $userParams ) > 0 )
        {
            foreach( $userParams as $key => $value )
            {
				if ($key == 'fragment'){
	                $userParamsString = $userParamsString . '#fragment-' . $value;
				} else {
		            $userParamsString = $userParamsString . '/'. '(' . $key . ')' . '/' . $value ;
				}
            }
        }

        return $Module->redirectTo( '/content/view/full/' . $mainNodeID . '/' . $userParamsString );
    }
    else
    {
        return $Module->handleError( EZ_ERROR_KERNEL_NOT_AVAILABLE, 'kernel' );
    }

?>
