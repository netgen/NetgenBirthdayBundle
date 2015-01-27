<?php

$Module = array( 'name' => 'Status' );

$ViewList = array();
$ViewList['set'] = array(
    'script' => 'setstatus.php',
    'params' => array(),
    'functions' => array( 'set' ),
    'single_post_actions' => array( 'Set' => 'Set' ),
    'post_action_parameters' => array( 'Set' => array( 'NodeIDList' => 'NodeIDList',
                                                       'SectionID' => 'SectionID',
                                                       'RedirectRelativeURI' => 'RedirectRelativeURI' ) )
);
$ViewList['init'] = array(
    'script' => 'init.php',
    'functions' => array( 'set' ),
    'params' => array('ObjectID')
);

$ClassID = array(
    'name'=> 'Class',
    'values'=> array(),
    'path' => 'classes/',
    'file' => 'ezcontentclass.php',
    'class' => 'eZContentClass',
    'function' => 'fetchList',
    'parameter' => array( 0, false, false, array( 'name' => 'asc' ) )
    );

$SectionID = array(
    'name'=> 'Section',
    'values'=> array(),
    'path' => 'classes/',
    'file' => 'ezsection.php',
    'class' => 'eZSection',
    'function' => 'fetchList',
    'parameter' => array( false )
    );

$FunctionList = array();

$FunctionList['set'] = array( 'Class' => $ClassID,
                                  'Section' => $SectionID );

?>
