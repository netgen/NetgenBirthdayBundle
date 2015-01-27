<?php
/**
 * File containing the module definition.
 *
 * @copyright Copyright (C) 1999-2012 eZ Systems AS. All rights reserved.
 * @license http://www.gnu.org/licenses/gpl-2.0.txt GNU General Public License v2
 *
 */

$Module = array( 'name' => 'ngAjaxCRUD' );

$ViewList = array();

$ViewList['status'] = array(
                   'functions' => array( 'view_status' ),
                   'script' => 'status.php',
                   'params' => array(  ),
                   );

$FunctionList = array();

$FunctionList['view_status'] = array();
$FunctionList['moderate_forum'] = array();
