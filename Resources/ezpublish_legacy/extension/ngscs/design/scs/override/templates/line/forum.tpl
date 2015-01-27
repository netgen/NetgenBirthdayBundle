<td>{if $node.depth|gt(3)}{for 4 to $node.depth as $i}&nbsp;&nbsp;&nbsp;{/for}{/if}<a href={$node.url_alias|ezurl}>{$node.name|wash}</a></td>
<td>{fetch('content','list_count',hash('parent_node_id',$node.node_id))}</td>
<td>{fetch('content','tree_count',hash('parent_node_id',$node.node_id))}</td>
<td>	{def $latest_forum_topics=fetch(  'content', 'tree', hash( parent_node_id, $node.node_id,
										  'limit', 3,
										  'class_filter_type', include,
										  'class_filter_array', array( 'forum_topic' ),
										  'sort_by', array( 'modified_subnode', false() ) ) )}

	<ul>
	{foreach $latest_forum_topics as $forum_topic}
		{def $last_reply=fetch('content','list',hash( 	'parent_node_id', $forum_topic.node_id,
														'sort_by', array( array( 'published', false() ) ),
														'limit', 1 ) )
		     $topic_reply_count=fetch( 'content', 'tree_count', hash( parent_node_id, $forum_topic.node_id ))}
			{if $last_reply|count|gt(0)}
				{if $topic_reply_count|gt( 19 )}
				    <li><a title="author: {$last_reply.0.object.owner.name|wash}" href={concat( $last_reply.0.parent.url_alias, '/(offset)/', sub( $topic_reply_count, mod( $topic_reply_count, 20 ) ) , '#msg', $last_reply.0.node_id )|ezurl}>{$forum_topic.name|wash}</a></li>
				{else}
				    <li><a title="author: {$last_reply.0.object.owner.name|wash}" href={concat( $last_reply.0.parent.url_alias, '#msg', $last_reply.0.node_id )|ezurl}>{$forum_topic.name|wash}</a></li>
				{/if}
			{else}
				<li><a title="author: {$forum_topic.object.owner.name|wash}" href={$forum_topic.url_alias|ezurl}>{$forum_topic.name|wash}</a></li>
			{/if}
		{undef $last_reply $topic_reply_count}
	{/foreach}
	</ul>
	{undef $latest_forum_topics}

</td>
