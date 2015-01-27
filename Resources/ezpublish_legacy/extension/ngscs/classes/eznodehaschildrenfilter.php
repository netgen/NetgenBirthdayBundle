<?php
class NodeHasChildrenFilter
{
    function NodeHasChildrenFilter()
    {
    }

    function createSqlParts( $params )
    {
        /*
         * Filtering nodes with a certain amount of children
         * 
         * By default it will only return nodes that have more then 0 children
         * but this can be customized to you need.
         * 
         * param 1: amount of children, default: 0
         * param 2: comparison clause, example: '!=', '=', '<=', '>=', '<', '>', default is '!='
         * 
         * Full example for fetching nodes that don't have children nodes:
         * ( in this case a 'is question anweared?' functionality )
         * 
         * {def $qa_list = fetch( 'content', 'tree', hash(
                                      'parent_node_id', 1503,
                                      'limit', 3,
                                      'sort_by', array( 'published', false() ),
                                      'class_filter_type', 'include',
                                      'class_filter_array', array( 'forum_topic' ),
                                      'extended_attribute_filter', hash( 'id', 'NodeHasChildrenFilter', 'params', array( 0, '=' ) )
                                      ) )}
         * 
         */
        $count = 0;
        $clause = '!=';

        if( isset( $params[0] ) && is_numeric( $params[0] ) )
        {
            $count = (int) $params[0];
        }

        if( isset( $params[1] ) && is_string( $params[1] ) )
        {
            $clause = $params[1];
        }

        $sqlJoins = " $count $clause ( SELECT count(*) FROM ezcontentobject_tree ezcontentobject_tree_2
                                 WHERE ezcontentobject_tree_2.parent_node_id = ezcontentobject_tree.node_id) AND ";
        return array('tables' => '', 'joins' => $sqlJoins, 'columns' => '');
    }
}
?>