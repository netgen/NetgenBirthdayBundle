<?php

class eZReverseRelationsFilter
{
    /*!
     Constructor
    */
    function eZReverseRelationsFilter()
    {
        // Empty...
    }

    function createSqlParts( $params )
    {
        $result = array( 'tables' => '', 'joins'  => '' );

        if ( isset( $params['class'] ) )
        {
             $class = $params['class'];
        } else
			return;

        if ( isset( $params['attrs'] ) )
        {
             $attrs = $params['attrs'];
        } else
			return;

		$filterSQL = array();
        $filterSQL['from']  = ", ezcontentobject_link i1 ";
        $filterSQL['columns']  = ", SUBSTRING(ezcontentobject.name,1,2) prefix ";

		$attribute_ids = array();
		foreach ($attrs as $attr) {
			array_push($attribute_ids,eZContentObjectTreeNode::classAttributeIDByIdentifier( $class . '/' . $attr ));
		}
		$class_cond = array();
		foreach ($attribute_ids as $aid) {
			if ($aid) {
			array_push($class_cond, 'i1.contentclassattribute_id = '.$aid);
			}
		}

        $string_class_cond = implode(" OR ",$class_cond);

        $filterSQL['where'] = " ( i1.from_contentobject_id = ezcontentobject.id 
			AND (" . $string_class_cond . ") 
			AND i1.from_contentobject_version = ezcontentobject.current_version 
			AND i1.to_contentobject_id = " . $params['object_id'] . ") AND ";

		return array( 'tables' => $filterSQL['from'], 'joins'  => $filterSQL['where'], 'columns' => $filterSQL['columns'] );

    }

    function createSqlPartsSlow( $params )
    {
    }
}

?>
