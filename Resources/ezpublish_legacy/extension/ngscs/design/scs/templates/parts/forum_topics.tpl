	<table class="list forum" cellspacing="0" width="100%">
	<tr>
	    <th class="topic">
		{"Topic"|i18n( "dms/forum_topic/line" )}
	    </th>
	    <th class="replies">
		{"Replies"|i18n( "dms/forum_topic/line" )}
	    </th>
	    <th class="author">
		{"Author"|i18n( "dms/forum_topic/line" )}
	    </th>
	    <th class="lastreply">
		{"Last reply"|i18n( "dms/forum_topic/line" )}
	    </th>
	</tr>

	{section var=topic loop=$topic_list sequence=array( bglight, bgdark )}
	{let $tnode=$topic}
	{if $tnode.object.class_identifier|eq('forum_reply')}{set $tnode=$topic.parent}{/if}
	{let topic_reply_count=fetch( 'content', 'tree_count', hash( parent_node_id, $tnode.node_id ) )
	     topic_reply_pages=sum( int( div( sum( $topic_reply_count, 1 ), 20 ) ), cond( mod( sum( topic_reply_count, 1 ), 20 )|gt( 0 ), 1, 0 ) )}
	<tr class="{$topic.sequence}">
	    <td class="topic">
		<p>{section show=$tnode.object.data_map.sticky.content}<img class="forum-topic-sticky" src={"sticky-16x16-icon.gif"|ezimage} height="16" width="16" align="middle" alt="" />{/section}
		<a href={$tnode.url_alias|ezurl}>{$tnode.object.name|wash}</a></p>
		{*section show=$topic_reply_count|gt( sub( 20, 1 ) )}
		    <p>
		    {'Pages'|i18n( 'dms/forum_topic/line' )}:
		    {section show=$topic_reply_pages|gt( 5 )}
			<a href={$tnode.url_alias|ezurl}>1</a>...
			{section var=reply_page loop=$topic_reply_pages offset=sub( $topic_reply_pages, sub( 5, 1 ) )}
			    <a href={concat( $tnode.url_alias, '/(offset)/', mul( sub( $reply_page, 1 ), 20 ) )|ezurl}>{$reply_page}</a>
			{/section}
		    {section-else}
			<a href={$tnode.url_alias|ezurl}>1</a>
			{section var=reply_page loop=$topic_reply_pages offset=1}
			    <a href={concat( $tnode.url_alias, '/(offset)/', mul( sub( $reply_page, 1 ), 20 ) )|ezurl}>{$reply_page}</a>
			{/section}
		    {/section}
		    </p>
		{/section*}
	    </td>
	    <td class="replies">
		<p>{$topic_reply_count}</p>
	    </td>
	    <td class="author">
		<div class="attribute-byline">
		   <p class="date">{$tnode.object.published|l10n(shortdatetime)}</p>
		   <p class="author">{$tnode.object.owner.name|wash}</p>
		</div>
	    </td>
	    <td class="lastreply">
	    {let last_reply=fetch('content','list',hash( parent_node_id, $tnode.node_id,
							 sort_by, array( array( 'published', false() ) ),
							 limit, 1 ) )}
		{section var=reply loop=$last_reply show=$last_reply}
		<div class="attribute-byline">
		   <p class="date">{$reply.object.published|l10n(shortdatetime)}</p>
		   <p class="author">{$reply.object.owner.name|wash}</p>
		</div>
		{section show=$topic_reply_count|gt( 19 )}
		    <p><a href={concat( $reply.parent.url_alias, '/(offset)/', sub( $topic_reply_count, mod( $topic_reply_count, 20 ) ) , '#msg', $reply.node_id )|ezurl}>{$reply.name|wash}</a></p>
		{section-else}
		    <p><a href={concat( $reply.parent.url_alias, '#msg', $reply.node_id )|ezurl}>{$reply.name|wash}</a></p>
		{/section}
		{section-else}
		   &nbsp;
		{/section}

	   {/let}
		</td>
	</tr>
	{/let}
	{/let}
	{/section}
	</table>
