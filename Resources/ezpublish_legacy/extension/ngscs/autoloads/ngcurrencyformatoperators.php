<?php

/*!
  \class   ngapronetOperators ngapronetoperators.php
  \ingroup eZTemplateOperators
  \brief   Handles template operators ngcurrency_format. By using ngcurrency_format you modify price for ngapronet in templates
  \version 1.0
  \date    Friday 27 January 2012 4:25:06 pm
  \author  Mario Ivancic

  ##############################################
  ngcurrency_format Operator Parameters:

  $input|ngcurrency_format( ['symbol'], ['isSymbolLast'], ['decimalSep'], ['thousandsSep'] )

\code
  Example 1:
  	{'100456'|ngcurrency_format()}
  Output 1:
  	€ 100 456,-  // uses locale default currency symbol

  Example 2:
  	{'1004.56'|ngcurrency_format( '£' )}
  Output 2:
  	£ 1,004.56 // uses locale default thousands and decimal separators and puts currency symbol at the end

  Example 3:
  	{'100456'|ngcurrency_format( '£' , true() )}
  Output 3:
  	 100 456 £

  Example 4:
  	{'1004.56'|ngcurrency_format( '£', true(), ',', ' ' )}
  Output 4:
  	1 004,56 £   // uses locale default thousands and decimal separators

  Example 6:
  	{'1004.56'|ngcurrency_format( '£', false(), ',', ' ' )}
  	or
  	{'1004.56'|ngcurrency_format( '£', '', ',', ' ' )}
  Output 6:
  	£ 1 004,56

\endcode
  ################################################
*/


class ngcurrencyOperators
{
	/*!
	  Constructor, does nothing by default.
	*/
	function ngapronetOperators()
	{
	}

	/*!
	 \return an array with the template operator name.
	*/
	function operatorList()
	{
		return array( 'ngcurrency_format' );
	}

	/*!
	 \return true to tell the template engine that the parameter list exists per operator type,
			 this is needed for operator classes that have multiple operators.
	*/
	function namedParameterPerOperator()
	{
		return true;
	}

	/*!
	 See eZTemplateOperator::namedParameterList
	*/
	function namedParameterList()
	{
		return array(	'ngcurrency_format' => array( 'symbol' => array(
																	'type' => 'string',
																	'required' => true,
																	'default' => '' ),
														 'isSymbolLast' => array(
															 		'type' => 'boolean',
																	'required' => false,
																	'default' => '' ),
														 'decimalSep' => array(
															 		'type' => 'string',
																	'required' => false,
																	'default' => '' ),
														 'thousandsSep' => array(
															 		'type' => 'string',
																	'required' => false,
																	'default' => '' ) ) );
	}


	/*!
	 Executes the PHP function for the operator cleanup and modifies \a $operatorValue.
	*/
	function modify( $tpl, $operatorName, $operatorParameters, $rootNamespace, $currentNamespace, &$operatorValue, $namedParameters, $placement )
	{
		switch ( $operatorName )
		{
			case 'ngcurrency_format':
			{
				$inputPrice = $operatorValue;
				$isFloat = ( strstr( $inputPrice, '.' ) || strstr( $inputPrice, ',' ) )? true : false;
				$isSymbolLast = $namedParameters['isSymbolLast']? true : false;
				$locale = eZLocale::instance();
				$symbol = $namedParameters['symbol'] ? $namedParameters['symbol'] : $locale->attribute('currency_symbol');
				$decimalSep = $namedParameters['decimalSep'] ? $namedParameters['decimalSep'] : $locale->attribute('currency_decimal_symbol');
				$thousandsSep = $namedParameters['thousandsSep'] ? $namedParameters['thousandsSep'] : $locale->attribute('currency_thousands_separator');
				//$formatNumber = ( !$isFloat )? number_format($inputPrice, 0, ',', ' ') : number_format( (float)$inputPrice, 2, $decimalSep, $thousandsSep);
				$formatNumber = ( !$isFloat )? number_format($inputPrice, 0, $decimalSep, $thousandsSep) : number_format( (float)$inputPrice, 2, $decimalSep, $thousandsSep);

				if ( $isSymbolLast )
				{
					$outputPrice = $formatNumber . ' ' . $symbol;
				}
				else
				{
					$outputPrice = $symbol . ' ' . $formatNumber;
					if ( !$isFloat )
						$outputPrice = $symbol . ' ' . $formatNumber . '';
				}

				$operatorValue = $outputPrice;
			} break;
		}
	}
}

?>
