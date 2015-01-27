{*cache-block keys=array( $user.contentobject_id )*}

{def $latest_content = fetch( 'content', 'tree', hash( 'parent_node_id',   ezini('DMSSettings', 'DiscussionsNodeID', 'dms.ini'),
                                                               'limit',            $block.number_of_items,
                                                               'class_filter_type', include,
                                                               'class_filter_array', array('forum_reply'),
                                                               'main_node_only',   true(),
                                                               'sort_by',          array( 'modified', false() ),
                                                               'attribute_filter', array( array( 'owner', '=', $user.contentobject_id ) ) ) )}

<h2>{'My latest discussions'|i18n( 'dms/dashboard' )}</h2>

{if $latest_content}

<table class="list hover-link" cellpadding="0" cellspacing="0" border="0" width="100%">
	<thead>
	    <tr>
	        <th>{'Name'|i18n( 'dms/dashboard' )}</th>
	        <th>{'Type'|i18n( 'dms/dashboard' )}</th>
	        <th>{'Modified'|i18n( 'dms/dashboard' )}</th>
	    </tr>
    </thead>
    <tbody>
	    {foreach $latest_content as $latest_node sequence array( 'bglight', 'bgdark' ) as $style}
	        <tr class="{$style}">
	            <td>
	                <a href={concat("content/view/full/",$latest_node.parent.node_id)|ezurl} title="{$latest_node.parent.name|wash()}">{$latest_node.parent.name|shorten('90')|wash()}</a>
	            </td>
	            <td>
	                {$latest_node.parent.class_name|d18n( 'dms/dashboard' )}
	            </td>
	            <td>
	                {$latest_node.parent.object.modified|l10n('shortdate')}
	            </td>
	        </tr>
	    {/foreach}
	</tbody>
</table>

{else}

<p>{'Your latest discussion list is empty.'|i18n( 'dms/dashboard' )}</p>

{/if}

{undef $latest_content}

{*/cache-block*}
