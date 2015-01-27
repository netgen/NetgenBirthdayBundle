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


<div class="row">
    <form name="browse" method="post" action={$browse.from_page|ezurl} id="browse-node">
    <div class="col-lg-11 col-sm-10">
        <div class="box">
            <div class="box-header" data-original-title>
                <h2><i class="fa fa-folder"></i><span class="break"></span>{'Browse'|i18n( 'design/admin/content/browse' )}</h2>
            </div>

            <div class="box-content">

                {if is_unset( $node_list )}{* changing limit while browsing search results not supported (search uses BrowsePageLimit GET parameter) *}
                    <p class="btn-group">
                        {switch match=$number_of_items}
                        {case match=25}
                            <button class="btn"><a href={'/user/preferences/set/admin_list_limit/1'|ezurl}>10</a></button>
                            <button class="btn" disabled><span class="current">25</span></button>
                            <button class="btn"><a href={'/user/preferences/set/admin_list_limit/3'|ezurl}>50</a></button>

                        {/case}

                        {case match=50}
                            <button class="btn"><a href={'/user/preferences/set/admin_list_limit/1'|ezurl}>10</a></button>
                            <button class="btn"><a href={'/user/preferences/set/admin_list_limit/2'|ezurl}>25</a></button>
                            <button class="btn" disabled> <span class="current">50</span></button>
                        {/case}

                        {case}
                            <button class="btn" disabled> <span class="current">10</span></button>
                            <button class="btn"> <a href={'/user/preferences/set/admin_list_limit/2'|ezurl}>25</a></button>
                            <button class="btn">  <a href={'/user/preferences/set/admin_list_limit/3'|ezurl}>50</a></button>
                        {/case}

                        {/switch}
                    </p>
                {/if}

                {if $browse.desription_template}
                    {include name=Description uri=$browse.description_template browse=$browse }
                {else}


                    <p>{'To select objects, choose the appropriate radio button or checkbox(es), then click the "Select" button.'|i18n( 'design/admin/content/browse' )}</p>

                {/if}

                <div class="context-block">
                {* DESIGN: Header START *}
                {if is_unset( $node_list )}
                    {let current_node=fetch( content, node, hash( node_id, $browse.start_node ) )}
                    {if $browse.start_node|gt( 1 )}
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

                <div class="form-actions hide">
                    <input type="submit" name="SelectButton" />
                    <input type="submit" name="BrowseCancelButton"  />
                </div>

            </div>
        </div>
    </div><!--/col-->

    <div class="col-lg-1 col-sm-2">
        <ul class="actions-nav">
            <li>
                <a href="#" onclick="ezpopmenu_submitForm( 'browse-node', null, 'SelectButton' ); return false;">
                    <i class="fa fa-plus-circle"></i>
                    <p>{"Select"|i18n("design/admin/content/browse")}</p>
                </a>
                <a href="#" onclick="ezpopmenu_submitForm( 'browse-node', null, 'BrowseCancelButton' ); return false;">
                    <i class="fa fa-times"></i>
                    <p>{"Discard"|i18n("design/admin/content/browse")}</p>
                </a>
            </li>
        </ul>
    </div>
    </form>

</div><!--/row-->
{/let}
