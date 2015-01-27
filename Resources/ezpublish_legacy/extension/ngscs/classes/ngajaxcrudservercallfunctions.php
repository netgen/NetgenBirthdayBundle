<?php
/**
 * File containing the ngAjaxCRUDServerCallFunctions class.
 *
 * @package ngajaxcrud
 * @version //autogentag//
 * @copyright Copyright (C) 2005-2009 eZ Systems AS. All rights reserved.
 * @license http://ez.no/licenses/new_bsd New BSD License
 */

class ngAjaxCRUDServerCallFunctions extends ezjscServerFunctions
{
    public static function display( $args )
    {
        $http = eZHTTPTool::instance();
        if ( $http->hasPostVariable( 'ObjectID' ) && $http->hasPostVariable( 'ClassIdentifier' ) && $http->hasPostVariable( 'ActionName' ) )
        {
            $classIdentifier = $http->postVariable( 'ClassIdentifier' );
            $actionName = $http->postVariable( 'ActionName' );

            $classObject = eZContentFunctionCollection::fetchClass( $classIdentifier );

            if ( isset( $classObject['error'] ) )
            {
                return "ngajaxcrud Error: Class $classIdentifier doesn't exist" ;
            }


            $contentObject = eZContentObject::fetch( (int) $http->postVariable( 'ObjectID' ) );
            $currentUser = eZUser::currentUser();
            $viewContentResult = self::viewContent( $contentObject->mainNodeID(), $classIdentifier );

            $hasAccessResult = $currentUser->hasAccessTo( 'ngajaxcrud', 'moderate_forum' );

            $layoutSuffix = '';
            if ( $http->hasPostVariable( 'Layout' ) )
                $layoutSuffix = "_" . $http->postVariable( 'Layout' );

            $tpl = eZTemplate::factory();

            $tpl->setVariable( "node", $contentObject->mainNode() );
            $tpl->setVariable( "object", $contentObject );
            $tpl->setVariable( "can_moderate", $hasAccessResult['accessWord'] != 'no' );
            $tpl->setVariable( "is_logged_in", $currentUser->isLoggedIn() );
            $tpl->setVariable( "class_identifier", $classIdentifier );
            $tpl->setVariable( "action_name", $actionName );

            $tpl->setVariable( "viewContentResult", $viewContentResult );

            $templateResult = $tpl->fetch( "design:ajax/content_create" . $layoutSuffix . ".tpl" );

            return $templateResult;
        }
    }

    function viewContent( $parentNodeID, $classIdentifier )
    {
        $http = eZHTTPTool::instance();

//        $parentNodeID = $http->hasPostVariable( 'ParentNode' );
        $treeParameters = array(
            'Depth' => 1
            );
        $additionalParameters = array();

        if ( $classIdentifier )
        {
            $additionalParameters['ClassFilterType'] = 'include';
            $additionalParameters['ClassFilterArray'] = array( $classIdentifier );
        }

        if ( $http->hasPostVariable( 'SortByAttribute' ) )
        {
            //array( ‘Limit’ => array( “name”, true ) )
            //array( ‘AttributeFilter’ => array( array( ‘name’, ‘like’, ‘David*’ ) ))
            $additionalParameters['SortBy'] = array( "attribute", true, "article_ld/order" ); //$http->postVariable( 'SortByAttribute' )
        }
        else
        {
            $additionalParameters['SortBy'] = array( 'published' , true );
        }

        $treeParameters = array_merge( $additionalParameters, $treeParameters );

        $children = eZContentObjectTreeNode::subTreeByNodeID( $treeParameters,
                                                                  $parentNodeID );

        $currentUser = eZUser::currentUser();
        $hasAccessResult = $currentUser->hasAccessTo( 'ngajaxcrud', 'moderate_forum' );

        $tpl = eZTemplate::factory();
        $tpl->setVariable( "class_identifier", $classIdentifier );
        $tpl->setVariable( "can_moderate", $hasAccessResult['accessWord'] != 'no' );
        $tpl->setVariable( "is_logged_in", $currentUser->isLoggedIn() );

        if ( $http->hasPostVariable( 'ShowBottomControls' ) && $http->postVariable( 'ShowBottomControls' ) == 1 && count($children) > 0 )
                $tpl->setVariable( "show_bottom_cotrols", $http->postVariable( 'ShowBottomControls' ) );

        $templateResult = '';

        if ( !count( $children ) )
        {
            return false;
        }

        foreach ( $children as $i => $contentObject )
        {
            $tpl->setVariable( "node", $contentObject->object()->mainNode() );
            $tpl->setVariable( "index_number", $i+1 );
            $templateResult .= $tpl->fetch( "design:ajax/$classIdentifier.tpl" );
        }

        return $templateResult;
    }

    public static function getLineObject( )
    {
        $http = eZHTTPTool::instance();
        if ( $http->hasPostVariable( 'ObjectID' ) )
        {
            $contentObject = eZContentObject::fetch( (int) $http->postVariable( 'ObjectID' ) );
            $currentUser = eZUser::currentUser();
            $hasAccessResult = $currentUser->hasAccessTo( 'ngajaxcrud', 'moderate_forum' );

            $classIdentifier = $contentObject->contentClass()->attribute('identifier');

            $tpl = eZTemplate::factory();

            $tpl->setVariable( "node", $contentObject->mainNode() );
            $tpl->setVariable( "object", $contentObject );
            $tpl->setVariable( "can_moderate", $hasAccessResult['accessWord'] != 'no' );
            $tpl->setVariable( "is_logged_in", $currentUser->isLoggedIn() );
            $tpl->setVariable( "class_identifier", $classArray['identifier'] );

            return $tpl->fetch( "design:ajax/$classIdentifier.tpl" );
        }

        return false;
    }

    public static function getSubtreeByNodeID( $parentNodeID )
    {
        $http = eZHTTPTool::instance();

        if ( $http->hasPostVariable( 'ParentNode' ) && $http->hasPostVariable( 'ClassIdentifier' ) )
        {
            return self::viewContent( (int) $http->postVariable( 'ParentNode' ), $http->postVariable( 'ClassIdentifier' ) );
        }

        return false;
    }

}
?>
