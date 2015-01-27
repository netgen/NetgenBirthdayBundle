<?php

class ngscsOperator
{
   /*!
    Constructor
   */
   function ngscsOperator()
   {
       $this->Operators = array('serverVars',
								'download_top_list',
                'set_session_var',
								'search_top_list',
								'search_add_phrase');
   }

   /*!
    Returns the operators in this class.
   */
   function operatorList()
   {
       return $this->Operators;
   }
 
   /*!
    \return true to tell the template engine that the parameter list
   exists per operator type, this is needed for operator classes
   that have multiple operators.
   */
   function namedParameterPerOperator()
   {
       return true;
   }

   /*!
    The first operator has two parameters, the other has none.
    See eZTemplateOperator::namedParameterList()
   */

   function namedParameterList()
   {
       return array( 'serverVars' => array( 'varname' => array( 'type' => 'string',
                                                                'required' => true,
                                                                'default' => '' ) ),		
					'download_top_list' => array( 'limit' => array( 'type' => 'string',
                                                                'required' => false,
                                                                'default' => '10' ) ),
          'set_session_var' => array( 'name' => array( 'type' => 'string',
                                                                'required' => true,
                                                                'default' => '' ),
                                      'var' => array( 'type' => 'string',
                                                                'required' => true,
                                                                'default' => '' ) ),
					'search_top_list' => array( 'limit' => array( 'type' => 'string',
                                                                'required' => false,
                                                                'default' => '10' ) ),
					'search_add_phrase' => array( 'phrase' => array( 'type' => 'string',
                                                                'required' => false,
                                                                'default' => '' ),
												'count' => array( 'type' => 'string',
                                                                'required' => false,
                                                                'default' => '' ) )
	   );
   }

   /*!
    Executes the needed operator(s).
    Checks operator names, and calls the appropriate functions.
   */
   function modify( $tpl, $operatorName, $operatorParameters, $rootNamespace,
                    $currentNamespace, &$operatorValue, $namedParameters )
   {
       switch ( $operatorName )
       {
           case 'serverVars':
           {
               $operatorValue = $this->getServerVars($namedParameters['varname']);
           } break;
           case 'download_top_list':
           {
               $operatorValue = $this->topDownloads($namedParameters['limit']);
           } break;
           case 'set_session_var':
           {
               $operatorValue = $this->setSessionVar($namedParameters['name'],$namedParameters['var']);
           } break;
           case 'search_top_list':
           {
               $operatorValue = $this->topSearchPhrases($namedParameters['limit']);
		   } break;
           case 'search_add_phrase':
           {
			   $operatorValue = $this->addSearchPhrase($namedParameters['phrase'],$namedParameters['count']);
           } break;
       }
   }

   function getServerVars( $args )
	{
		if (isset($_SERVER[$args['varname']])) 
		{
			return $_SERVER[$args['varname']];
		}
		return $args['varname'];
	}

	function topDownloads( $args )
	{
		$db = eZDB::instance();

		$rows = $db->arrayQuery( "SELECT contentobject_id FROM ezbinaryfile, ezcontentobject_attribute where ezcontentobject_attribute.id = ezbinaryfile.contentobject_attribute_id order by download_count desc limit 0,". $args['limit'] );

		$objects = false;
		foreach ( $rows as $row )
		{
			$objects[] = eZContentObject::fetch( $row['contentobject_id'] );
		}
		return $objects;
	}

	function topSearchPhrases( $args )
	{
		$viewParameters = array( 'offset' => 0, 'limit'  => $args['limit'] );

		$mostFrequentPhraseArray = eZSearchLog::mostFrequentPhraseArray( $viewParameters );

		return $mostFrequentPhraseArray;
	}

	function addSearchPhrase( $phrase, $count )
	{
		if (strlen($phrase) && strlen($count)) {
			eZSearchLog::addPhrase( $phrase, $count );
		}
	}

  function setSessionVar( $name, $var )
  {
    $http = eZHTTPTool::instance();
    $http->setSessionVariable($name,$var);
  }
   /// \privatesection
   var $Operators;
}

?>