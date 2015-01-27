<?php
class NodeChildrenCountFilter
{
    function NodeChildrenCountFilter()
    {
    }

    function createSqlParts( $params )
    {
		$classes = "";
		if (isset( $params[0] ) && is_array( $params[0] )) {
			$classes = " AND ezcontentobject.contentclass_id IN (" . implode(',',$params[0]) . ") ";
		}
        return array('tables' => "", 'joins' => "", 'columns' => ", ( SELECT count(*) FROM ezcontentobject_tree ezcontentobject_tree_2, ezcontentobject
                                 WHERE ezcontentobject_tree_2.parent_node_id = ezcontentobject_tree.node_id
								 AND ezcontentobject.id = ezcontentobject_tree_2.contentobject_id
								 AND ezcontentobject.current_version = ezcontentobject_tree_2.contentobject_version
								 $classes ) AS children_count ");
    }
}
?>