<?php
	$eZTemplateOperatorArray = array();

	$eZTemplateOperatorArray[] = array(
		'script' => 'extension/ngscs/autoloads/redirectoperator.php',
		'class' => 'RedirectOperator',
		'operator_names' => array( 'redirect' )	);

    $eZTemplateOperatorArray[] = array(
        'script' => 'extension/ngscs/autoloads/ngscs_operators.php',
        'class' => 'ngscsOperator',
        'operator_names' => array( 'serverVars', 'download_top_list', 'set_session_var', 'search_top_list', 'search_add_phrase' ) );

    $eZTemplateOperatorArray[] = array(
        'script' => 'extension/ngscs/autoloads/ngcurrencyformatoperators.php',
        'class' => 'ngcurrencyOperators',
        'operator_names' => array( 'ngcurrency_format' ) );

?>
