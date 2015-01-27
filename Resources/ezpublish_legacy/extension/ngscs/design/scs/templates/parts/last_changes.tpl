{default $limit=5}
{cache-block expiry=1800 keys=$user.groups|append($node_id)|append($limit) ignore_content_expiry}
<div class="right-info">
	{def $new_list=fetch( 'content', 'tree', hash( parent_node_id, $node_id, 
							class_filter_type, include,
							class_filter_array, array('dossier_ap','dossier_ld'),
							sort_by, array( 'modified', false() ), 
							limit, $limit  ) )} 
	<div>
		<h2>{"Last change"|i18n( 'dms/parts' )}</h2>
		{if $new_list|count}
		<ul>
		{section var=child loop=$new_list sequence=array(bglight,bgdark)}
			{if or($child.object.class_identifier|eq('dossier'),$child.object.class_identifier|eq('dossier_ld'))}
				<li><a href={concat("/content/view/full/",$child.node_id)|ezurl}>{$child.name|shorten}</a> ({$child.object.class_name|d18n('dms/parts')})</li>
			{else}
				<li>{node_view_gui view=listitem content_node=$child} ({$child.object.class_name|d18n('dms/parts')} - {"dossier"|i18n( 'dms/parts' )}: <a href={concat("/content/view/full/",$child.parent.node_id)|ezurl}>{$child.parent.data_map.id.content}</a>)</li>
			{/if}
		{/section}
		</ul>
		{/if}
	</div>
</div>
{/cache-block}
{default}