<?php

$Module = array( 'name' => 'Access' );

// Define module views.
$ViewList = array();
$ViewList['try'] = array(
    'script' => 'try.php',
    'functions' => array( 'try' ),
    'single_post_actions' => array( 'TryToAccess' => 'RedirectLink' ),
    'post_action_parameters' => array( 'RedirectLink' => array( 'RedirectURI' => 'RedirectURI',
    															'ModulePermission' => 'ModulePermission',
    															'FunctionPermission' => 'FunctionPermission' ) )
);

// Define module functions (used by permission system).
$FunctionList = array();

$FunctionList['try'] = array( );
$FunctionList['review_tab'] = array();
$FunctionList['non_public'] = array();

?>
