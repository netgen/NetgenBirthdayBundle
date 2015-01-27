{set-block variable=$action_items}
{if $node.can_edit}
    <li>
        <a href="#" onclick="ezpopmenu_submitForm( 'create-topic' ); return false;">
            <i class="fa fa-plus-circle"></i>
            <p>{"New discussion"|i18n( 'dms/full/forum' )}</p>
        </a>
        <form style="display: none" id="create-topic" method="post" action={"/content/action"|ezurl}>

            <input type="hidden" value="{$node.node_id}" name="ContentNodeID">
            <input type="hidden" value="{$node.contentobject_id}" name="ContentObjectID">
            <input type="hidden" value="{$node.node_id}" name="NodeID">
            <input type="hidden" value="forum" name="ClassIdentifier">
            <input type="hidden" value="" name="NewButton">
            <input type="hidden" value="{$node.object.current_language}" name="ContentLanguageCode">

        </form>
    </li>
{/if}
{if ezini( 'RegionalSettings', 'Locale', 'site.ini' )|ne('eng-GB')}
    {if $node.can_edit}
        <li>
            {if $node.object.language_codes|contains(ezini( 'RegionalSettings', 'Locale', 'site.ini' ))|not}
                <a href="#" onclick="ezpopmenu_submitForm( 'translate' ); return false;">
                    <i class="fa fa-pencil"></i>
                    <p>{"Translate from english"|i18n( 'dms_armenia/agencies/full' )}</p>
                </a>
                <form method="post" action={concat("/content/edit/", $node.contentobject_id)|ezurl} id="translate">
                    <input type="hidden" name="EditLanguage" value="{ezini( 'RegionalSettings', 'Locale', 'site.ini' )}" />
                    <input type="hidden" name="FromLanguage" value="eng-GB" />
                    <input type="hidden" name="LanguageSelection" value="Edit" />
                </form>
            {else}
                <a onclick="ezpopmenu_submitForm( 'edit' ); return false;" href="#">
                    <i  class="fa fa-pencil"></i>
                    <p>{"Edit"|i18n("dms/full/agency")}</p>
                </a>
                <form method="post" action={"/content/action"|ezurl} id="edit">
                    <input type="hidden" name="NodeID" value="{$node.node_id}" />
                    <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                    <input type="hidden" name="EditButton" value="" />
                    <input type="hidden" name="ContentObjectLanguageCode" value="{$node.object.current_language}" />
                </form>
            {/if}
        </li>
    {/if}
{/if}
{/set-block}

{if $node.can_edit}
{set scope=global persistent_variable=hash('action_items', $action_items)}
{/if}

<div class="row">
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header" data-original-title>
                <h2><i class="fa fa-comments"></i><span class="break"></span>{$node.object.data_map.title.content|wash()|d18n( 'dms/full/folder' )|upcase}</h2>
                <div class="box-icon">
                	{if $node.parent.class_identifier|eq('forums')}
						<a href={$node.parent.url_alias|ezurl}><i class="fa fa-chevron-left"></i></a>
					{/if}
                </div>
            </div>

            <div class="box-content">
            	{if $node.object.data_map.description.has_content}
                    <div class="attribute-long">
                        {attribute_view_gui attribute=$node.object.data_map.description}
                    </div>
                {/if}

                {def $forum_limit = 15}
				{def $list_items=fetch( 'content','list', hash(  'parent_node_id', $node.node_id,
																 'limit', $forum_limit,
															     'offset', $view_parameters.offset,
															     'class_filter_type', include,
															     'class_filter_array', array( 'forum' ),
															     'sort_by', $node.sort_array) )}
				{def $forum_count=fetch('content','list_count',hash( 'parent_node_id',$node.node_id,
																	 'class_filter_type', include,
																	 'class_filter_array', array('forum')))}
				{if $list_items|count}
					<table class="table table-striped table-bordered bootstrap-datatable datatable">
	                	<thead>
	                        <tr>
	                            <th>{"Discussion"|i18n( "dms/full/forum" )}</th>
							    <th>{"Number of Topics"|i18n( "dms/full/forum" )}</th>
							    <th>{"Number of Posts"|i18n( "dms/full/forum" )}</th>
							    <th>{"Last topics"|i18n( "dms/full/forum" )}</th>
	                        </tr>
	                    </thead>

	                    <tbody>
	                    	{foreach $list_items as $list_item}
	                    		<tr>{node_view_gui view='line' content_node=$list_item}</tr>
	                    	{/foreach}
	                    </tbody>
	                </table>

	                {include name=navigator
							 uri='design:navigator/google.tpl'
							 page_uri=concat('/content/view','/full/',$node.node_id)
							 item_count=$forum_count
							 view_parameters=$view_parameters
							 item_limit=$forum_limit}
				{/if}
            </div>
		</div>
	</div>
</div>



