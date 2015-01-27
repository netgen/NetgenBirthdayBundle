{def $item_type = ezpreference( 'admin_eztags_list_limit' )}
{def $number_of_items = 15}

{def $children = fetch( tags, list, hash( parent_tag_id, first_set( $tag.id, 0 ),
                                          offset, first_set( $view_parameters.offset, 0 ),
                                          limit, $number_of_items ) )}

{def $children_count = fetch( tags, list_count, hash( parent_tag_id, first_set( $tag.id, 0 ) ) )}
        {if $children_count|gt(0)}
            <table class="table table-striped table-bordered" cellspacing="0">
                <tbody>
                    <tr>
                        <th>{"ID"|i18n( "dms/tags" )}</th>
                        <th>{"Tag name"|i18n( "dms/tags" )}</th>
                        <th>{"Modified"|i18n( "dms/tags" )}</th>
                        {*<th class="tight">{"Action"|i18n( "dms/tags" )}</th>*}
                    </tr>
                    {foreach $children as $child_tag sequence array('bglight', 'bgdark') as $sequence}
                        <tr class="{$sequence}">
                            <td>{$child_tag.id}</td>
                            <td><a href={concat( '/tags/id/', $child_tag.id )|ezurl} title="{$child_tag.keyword|wash}{cond( $child_tag.synonyms_count|gt(0), concat( ' (+', $child_tag.synonyms_count, ')' ), '' )}">{$child_tag.keyword|wash}{cond( $child_tag.synonyms_count|gt(0), concat( ' (+', $child_tag.synonyms_count, ')' ), '' )}</a></td>
                            <td>{$child_tag.modified|datetime( 'custom', '%d.%m.%Y %H:%i' )}</td>
                            {*
                            <td>
                                <a class="show-icon" href={concat( '/tags/id/', $child_tag.id )|ezurl} title="{'Show'|i18n('dms/tags')}">{'Show'|i18n('dms/tags')}</a>
                                {if $tag_exists}
                                <a class="edit-icon" href={concat( '/tags/edit/', $child_tag.id )|ezurl} title="{'Edit'|i18n('dms/tags')}">{'Edit'|i18n('dms/tags')}</a>
                                <a class="delete-icon" href={concat( '/tags/delete/', $child_tag.id )|ezurl} title="{'Delete'|i18n('dms/tags')}">{'Delete'|i18n('dms/tags')}</a>
                                {/if}
                            </td>
                            *}
                        </tr>
                    {/foreach}
                </tbody>
            </table>
                {include uri='design:navigator/google.tpl'
                         page_uri=cond( is_set( $tag ), concat( '/tags/id/', $tag.id ), '/tags/dashboard' )
                         item_count=$children_count
                         view_parameters=$view_parameters
                         item_limit=$number_of_items}
        {else}
            <p>{'The current tag does not contain any children.'|i18n( 'dms/tags' )}</p>
        {/if}
{undef}
