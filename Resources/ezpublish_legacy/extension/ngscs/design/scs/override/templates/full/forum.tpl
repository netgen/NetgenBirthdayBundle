{set-block variable=$action_items}
{if $node.can_create}
    <li>
        <a href="#" onclick="ezpopmenu_submitForm( 'create-topic' ); return false;">
            <i class="fa fa-plus-circle"></i>
            <p>{"New topic"|i18n( 'dms/full/forum' )}</p>
        </a>
        <form style="display: none" id="create-topic" method="post" action={"/content/action"|ezurl}>

            <input type="hidden" value="{$node.node_id}" name="ContentNodeID">
            <input type="hidden" value="{$node.contentobject_id}" name="ContentObjectID">
            <input type="hidden" value="{$node.node_id}" name="NodeID">
            <input type="hidden" value="forum_topic" name="ClassIdentifier">
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
            {elseif $node.can_edit}
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

{if $node.can_create}
{set scope=global persistent_variable=hash('action_items', $action_items, 'full_view_scripts_bottom', array('ezpopupmenu.js'))}
{/if}

<div class="row">
	<div class="col-lg-12">
		<div class="box">
			<div class="box-header" data-original-title>
                <h2><i class="fa fa-comments"></i><span class="break"></span>{$node.data_map.name.content|wash|d18n( 'dms/full/folder' )|upcase}</h2>
                <div class="box-icon">
                	{if $node.parent.class_identifier|eq('forums')}
                		<a class="forum-up" href={$node.parent.url_alias|ezurl}>{"Go up"|i18n( "dms/full/forum" )}</a>
					{/if}
                </div>
            </div>

            <div class="box-content">
            	{if $node.object.data_map.description.has_content}
                    <div class="attribute-long">
                        {attribute_view_gui attribute=$node.object.data_map.description}
                    </div>
                {/if}

                {def $topic_limit = 15}
				{def $topic_list=fetch( 'content','tree', hash( 'parent_node_id', $node.node_id,
										 'limit', $forum_limit,
									     'offset', $view_parameters.offset,
									     'class_filter_type', include,
									     'class_filter_array', array( 'forum_topic' ),
									     'sort_by', $node.sort_array) )}
				{def $topic_count=fetch( 'content','list_count',hash( 'parent_node_id',$node.node_id,
																	  'class_filter_type', include,
																	  'class_filter_array', array('forum_topic')))}
				{if $topic_count|count}
					<table class="table table-striped table-bordered bootstrap-datatable datatable">
	                	<thead>
	                        <tr>
	                            <th>{"Topic"|i18n( "dms/full/forum" )}</th>
							    <th>{"Replies"|i18n( "dms/full/forum" )}</th>
							    <th>{"Author"|i18n( "dms/full/forum" )}</th>
							    <th>{"Last reply"|i18n( "dms/full/forum" )}</th>
	                        </tr>
	                    </thead>

	                    <tbody>
	                    	{foreach $topic_list as $topic_list_item}
	                    		<tr>{node_view_gui view='line' content_node=$topic_list_item}</tr>
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



