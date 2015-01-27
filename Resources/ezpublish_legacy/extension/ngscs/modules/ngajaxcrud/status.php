<?php

$module = $Params['Module'];
$currentUser = eZUser::currentUser();
$http = eZHttpTool::instance();
$tpl = eZTemplate::factory();

$Result = array();
$Result['content'] = "";
?>