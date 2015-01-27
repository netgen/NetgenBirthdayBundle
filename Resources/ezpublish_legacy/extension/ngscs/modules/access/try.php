<?php

$Module = $Params['Module'];

$http = eZHTTPTool::instance();

if ($http->hasSessionVariable('LastAccessesURI'))
    $redirectLink = $http->sessionVariable('LastAccessesURI', '/');

if ($Module->currentAction() == 'RedirectLink')
{
    $redirectLink = $Module->actionParameter('RedirectURI');
}

$user = eZUser::currentUser();

if ( $Module->hasActionParameter('ModulePermission') && $Module->hasActionParameter('FunctionPermission') && ( $Module->actionParameter('ModulePermission') != '' && $Module->actionParameter('FunctionPermission') != '' ) )
{
    $accessArray = $user->hasAccessTo( $Module->actionParameter( 'ModulePermission' ), $Module->actionParameter( 'FunctionPermission' ) );
}
else
{
    $accessArray = array();
}

if ( !empty( $accessArray ) )
{
    if ( $accessArray['accessWord'] != 'no' )
    {
        return $Module->redirectTo( $redirectLink );
    }
    else
    {
        $http->setSessionVariable( "RedirectAfterLogin", $redirectLink );
        return $Module->redirect( 'user', 'login' );
    }
}
else
{
    if ( $user->attribute('is_logged_in') != false )
    {
        return $Module->redirectTo( $redirectLink );
    }
    else
    {
        $http->setSessionVariable( "RedirectAfterLogin", $redirectLink );
        return $Module->redirect( 'user', 'login' );
    }
}

?>
