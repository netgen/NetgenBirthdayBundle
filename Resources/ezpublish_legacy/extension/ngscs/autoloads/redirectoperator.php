<?php
 
class RedirectOperator
{
    function RedirectOperator()
    {
        $this->Operators = array( 'redirect' );
    }
 
    function &operatorList()
    {
        return $this->Operators;
    }
 
    function namedParameterPerOperator()
    {
        return true;
    }
 
    function namedParameterList()
    {
        return array(
            'redirect' => array(
                'url' => array(
                    'type' => 'string',
                    'required' => true
                )
            )
        );
    }
 
    function modify( &$tpl, &$operatorName, &$operatorParameters, &$rootNamespace,
                     &$currentNamespace, &$operatorValue, &$namedParameters )
    {
        include_once( 'lib/ezutils/classes/ezsys.php' );
        include_once( 'lib/ezutils/classes/ezhttptool.php' );
        include_once( 'lib/ezutils/classes/ezexecution.php' );
 
        $redirectUri = $namedParameters['url'];
        // if $redirectUri is not starting with scheme://
        if ( !preg_match( '#^\w+://#', $redirectUri ) )
        {
            // path to eZ Publish index
            $indexDir = eZSys::indexDir();
 
            /* We need to make sure we have one
               and only one slash at the concatenation point
               between $indexDir and $redirectUri. */
            $redirectUri = rtrim( $indexDir, '/' ) . '/' . ltrim( $redirectUri, '/' );
        }
 
        // Redirect to $redirectUri by returning status code 301 and exit.
        eZHTTPTool::redirect( $redirectUri, array(), 301 );
        eZExecution::cleanExit();
    }
}
 
?>