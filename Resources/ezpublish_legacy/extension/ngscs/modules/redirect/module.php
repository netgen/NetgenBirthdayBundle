<?php

$Module = array( 'name' => 'Redirect' );

// Define module views.
$ViewList = array();
$ViewList['mainnode'] = array(
    'script' => 'mainnode.php',
    'functions' => array( 'redirect' ),
    'params' => array( 'ObjectID' )
);

// Define module functions (used by permission system).
$FunctionList['redirect'] = array( );

?>
