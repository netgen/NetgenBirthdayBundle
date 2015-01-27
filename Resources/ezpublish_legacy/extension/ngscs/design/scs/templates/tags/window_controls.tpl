{def $tag_exists = is_set( $tag )}

{if $tag_exists}
    {def $tag_url                 = concat( 'tags/id/', $tag.id )
         $tab_index               = first_set( $view_parameters.tab, 'children' )
         $valid_tabs              = array( 'content', 'children', 'latest', 'translations', 'synonyms'  )
         $read_open_tab_by_cookie = true()
    }
{else}
    {def $tag_url                 = 'tags/dashboard'
         $tab_index               = first_set( $view_parameters.tab, 'children' )
         $valid_tabs              = array( 'children', 'latest' )
         $read_open_tab_by_cookie = true()
    }
{/if}

{def $children_count = fetch( tags, list_count, hash( parent_tag_id, first_set( $tag.id, 0 ) ) )}

{if $valid_tabs|contains( $tab_index )|not()}
    {set $tab_index = cond( $tag_exists, 'content', 'children' )}
{elseif is_set( $view_parameters.tab )}
    {set $read_open_tab_by_cookie = false()}
{/if}


    <div class="row">
        <div class="col-lg-6">
            <div class="box">
                <div class="box-header">
                    <h2><i class="fa fa-bookmark"></i>{'Children tags (%children_count)'|i18n( 'dms/tags',, hash( '%children_count', $children_count ) )}</h2>
                </div>

                <div class="box-content">
                    {include uri='design:tags/tabs/eztags_children.tpl' tag_exists=$tag_exists}

                    {if fetch( user, has_access_to, hash( module, tags, function, add ) ) }
                        <form name="tagadd" id="tagadd" enctype="multipart/form-data" method="post" action={concat( 'tags/add/', $tag.id )|ezurl}>
                            <input type="submit" class="btn btn-success" name="tagadd" id="tagadd" value="{"Add child tag"|i18n( "dms/tags" )}" />
                            <input class="defaultbutton" type="hidden" name="SubmitButton" value="{"Add child tag"|i18n( "dms/tags" )}" />
                        </form>
                    {/if}
                </div>
            </div>
        </div>
        {if $tag_exists}
            <div class="col-lg-6">
                <div class="box">
                    <div class="box-header">
                        <h2><i class="fa fa-link"></i>{'Tag translations'|i18n( 'dms/tags' )} ({$tag.translations_count})</h2>
                    </div>

                    <div class="box-content">
                        {include uri='design:tags/tabs/translations.tpl'}
                    </div>
                </div>
            </div>
        {else}
            <div class="col-lg-1">
                {def $shortcut_node = fetch(content, node, hash(node_id, 157))}
                {include uri='design:parts/modal_buttons.tpl' node=$shortcut_node}
            </div>
        {/if}
    </div>

{if and( $tag_exists|not(), and( $tag_exists, $tag.main_tag_id|eq( 0 ) ) )}
    <div class="row">
        {if $tag_exists|not()}
            <div class="col-lg-6">
                <div class="box">
                    <div class="box-header">
                        <h2><i class="fa fa-tags"></i>{'Latest tags'|i18n( 'dms/tags' )}</h2>
                    </div>

                    <div class="box-content">
                        {include uri='design:tags/tabs/latest_tags.tpl'}
                    </div>
                </div>
            </div>
        {/if}

        {if and( $tag_exists, $tag.main_tag_id|eq( 0 ) )}
            <div class="col-lg-6">
                <div class="box">
                    <div class="box-header">
                        <h2><i class="fa fa-list-alt"></i>{'Synonyms'|i18n( 'dms/tags' )} ({$tag.synonyms_count})</h2>
                    </div>

                    <div class="box-content">
                        {include uri='design:tags/tabs/synonyms.tpl'}
                    </div>
                </div>
            </div>
        {/if}
    </div>
{/if}
{if $tag_exists}
<div class="row">
    <div class="col-lg-12">
        <div class="box">
            <div class="box-header">
                <h2><i class="fa fa-clock-o"></i>{'Latest content tagged by'|i18n( 'dms/tags' )} {$tag.keyword|wash()}</h2>
            </div>

            <div class="box-content">
                {include uri='design:tags/tabs/latest_content.tpl'}
            </div>
        </div>
    </div>
</div>
{/if}










