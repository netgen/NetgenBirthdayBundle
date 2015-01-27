{def $main_node_id = $main_node.node_id
	 $object_id = $main_node.object.id
	 $current_language = $main_node.object.current.contentobject.current_language}

<a href={concat('content/view/full/', $main_node_id)|ezurl()} class="show-icon" title="{'Show'|i18n('dms/helper/php')}">{'Show'|i18n('dms/helper/php')}</a>
<a href={concat('content/edit/', $object_id, '/f/', $current_language)|ezurl()} class="edit-icon" title="{'Edit'|i18n('dms/helper/php')}">{'Edit'|i18n('dms/helper/php')}</a>