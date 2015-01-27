{let item_type=ezpreference( 'admin_list_limit' )
     number_of_items=min( $item_type, 3)|choose( 10, 10, 25, 50 )
     select_name='SelectedObjectIDArray'
     select_type='checkbox'
     select_attribute='contentobject_id'
     browse_list_count=0
     page_uri_suffix=false()
     node_array=array()
     bookmark_list=fetch('content','bookmarks',array())}

{if is_set( $node_list )}
    {def $page_uri=$requested_uri }
    {set browse_list_count = $node_list_count
         node_array        = $node_list
         page_uri_suffix   = concat( '?', $requested_uri_suffix)}
{else}
    {def $page_uri=concat( '/content/browse/', $main_node.node_id )}

    {set browse_list_count=fetch( content, list_count, hash( parent_node_id, $node_id, depth, 1, objectname_filter, $view_parameters.namefilter) )}
    {if $browse_list_count}
        {set node_array=fetch( content, list, hash( parent_node_id, $node_id, depth, 1, offset, $view_parameters.offset, limit, $number_of_items, sort_by, $main_node.sort_array, objectname_filter, $view_parameters.namefilter ) )}
    {/if}
{/if}

{if eq( $browse.return_type, 'NodeID' )}
    {set select_name='SelectedNodeIDArray'}
    {set select_attribute='node_id'}
{/if}

{if eq( $browse.selection, 'single' )}
    {set select_type='radio'}
{/if}

<form name="browse" method="post" action={$browse.from_page|ezurl} id="browse-node">
    <div class="modal-header">
        <input type="submit" class="close" name="DiscardButton" value="&times;" />
        <h4 class="modal-title">{'Browse'|i18n( 'design/admin/content/browse' )}</h4>
    </div>

    <div class="modal-body">
        <div class="col-lg-12">
            {*if is_unset( $node_list )}
                <p class="btn-group">
                    {switch match=$number_of_items}
                    {case match=25}
                        <a class="btn" href={'/user/preferences/set/admin_list_limit/1'|ezurl}>10</a>
                        <span class="current">25</span></button>
                        <a class="btn" href={'/user/preferences/set/admin_list_limit/3'|ezurl}>50</a>

                    {/case}

                    {case match=50}
                        <a class="btn" href={'/user/preferences/set/admin_list_limit/1'|ezurl}>10</a>
                        <a class="btn" href={'/user/preferences/set/admin_list_limit/2'|ezurl}>25</a>
                        <span class="current">50</span>
                    {/case}

                    {case}
                        <span class="current">10</span>
                        <a class="btn" href={'/user/preferences/set/admin_list_limit/2'|ezurl}>25</a>
                        <a class="btn" href={'/user/preferences/set/admin_list_limit/3'|ezurl}>50</a>
                    {/case}

                    {/switch}
                </p>
            {/if*}

            {if $browse.desription_template}
                {include name=Description uri=$browse.description_template browse=$browse }
            {else}


                <p>{'To select objects, choose the appropriate radio button or checkbox(es), then click the "Select" button.'|i18n( 'design/admin/content/browse' )}</p>
                <p>{'To select an object that is a child of one of the displayed objects, click the object name for a list of the children of the object.'|i18n( 'design/admin/content/browse' )}</p>

            {/if}

            <div class="context-block">
            {* DESIGN: Header START *}
            {if is_unset( $node_list )}
                {let current_node=fetch( content, node, hash( node_id, $browse.start_node ) )}
                {if $browse.start_node|gt( 1 )}
                    <a {if $browse.top_level_nodes|contains($main_node.node_id)}disabled{/if} class="btn btn-small" href={concat( '/content/browse/', $main_node.parent_node_id, '/' )|ezurl}><i class="fa fa-arrow-up"></i> {'Up'|i18n( 'design/admin/content/browse' )}</a>
                    <h2>{$current_node.name|wash}&nbsp;[{$browse_list_count}]</h2>
                {else}
                <h2> {'Top level'|i18n( 'design/admin/content/browse' )}&nbsp;[{$current_node.children_count}]</h2>
                {/if}
                {/let}
            {else}
             <h2> {'Search result'|i18n( 'design/admin/content/browse' )}&nbsp;[{$browse_list_count}]</h2>

            {/if}

            {include uri='design:content/browse_mode_list.tpl'}

            {include name=navigator
                uri='design:navigator/alphabetical.tpl'
                page_uri=$page_uri
                page_uri_suffix=$page_uri_suffix
                item_count=$browse_list_count
                view_parameters=$view_parameters
                node_id=$node_id
                item_limit=$number_of_items
                show_google_navigator=true()}

            {section var=PersistentData show=$browse.persistent_data loop=$browse.persistent_data}
                <input type="hidden" name="{$PersistentData.key|wash}" value="{$PersistentData.item|wash}" />
            {/section}

            <input type="hidden" name="BrowseActionName" value="{$browse.action_name}" />
            {if $browse.browse_custom_action}
                <input type="hidden" name="{$browse.browse_custom_action.name}" value="{$browse.browse_custom_action.value}" />
            {/if}

            {if $cancel_action}
            <input type="hidden" name="BrowseCancelURI" value="{$cancel_action}" />
            {/if}


            </div>


        </div>
    </div>

    <div class="modal-footer">
        <div class="col-lg-12">
            <div class="form-actions">
                <input class="btn btn-primary" type="submit" name="SelectButton" value="{"Select"|i18n("design/admin/content/browse")}" />
                <input class="btn" type="submit" name="BrowseCancelButton" value="{"Discard"|i18n("design/admin/content/browse")}" />
            </div>
        </div>
    </div>

</form>
{/let}
