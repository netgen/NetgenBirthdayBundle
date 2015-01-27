{def $user_hash = concat( $user.role_id_list|implode( ',' ), ',', $user.limited_assignment_value_list|implode( ',' ) )}

{cache-block keys=array( $user_hash )}

{* We only fetch items within last 7 days to make sure we don't generate to heavy sql queries *}
{def $date_end = sub( currentdate(), 604800 )
     $all_latest_content = fetch( 'content', 'tree', hash( 'parent_node_id',   ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                                                           'limit',            $block.number_of_items,
                                                            'class_filter_type', include,
                                                            'class_filter_array', array('dossier_ap', 'dossier_ld','dossier_co', 'article_amended_ld', 'article_ld', 'file', 'private_file'),
                                                           'main_node_only',   true(),
                                                           'attribute_filter', array( array( 'published', '>=',$date_end ) ),
                                                           'sort_by',          array( 'published', false() ) ) )
     $current_lang = ''}

<h2>{'All latest content'|i18n( 'dms/dashboard' )}</h2>

{if $all_latest_content}

<table class="list hover-link" cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
        <th>{'Name'|i18n( 'dms/dashboard' )}</th>
        <th>{'Type'|i18n( 'dms/dashboard' )}</th>
        <th>{'Published'|i18n( 'dms/dashboard' )}</th>
        {* <th class="tight"></th> *}
    </tr>
    {foreach $all_latest_content as $latest_node sequence array( 'bglight', 'bgdark' ) as $style}
        {set $current_lang = $latest_node.object.current.contentobject.current_language}
        <tr class="{$style}">
            <td>
                <a href={concat("content/view/full/",$latest_node.node_id)|ezurl} title="{$latest_node.name|wash()}">{$latest_node.name|shorten('90')|wash()}</a>
            </td>
            <td>
                {$latest_node.class_name|d18n( 'dms/dashboard' )}
            </td>
            <td>
                {$latest_node.object.published|l10n('shortdate')}
            </td>
            {*
            <td>
            {if $latest_node.can_edit}
                <a class="edit-icon" href="{concat( 'content/edit/', $latest_node.contentobject_id, '/f/', $current_lang )|ezurl('no')}" title="{"Edit"|i18n('dms/dashboard')}">{"Edit"|i18n('dms/dashboard')}</a>
            {/if}
            </td>
            *}
        </tr>
        {set $current_lang = ''}
    {/foreach}
</table>

{else}

<p>{'Latest content list is empty.'|i18n( 'dms/dashboard' )}</p>

{/if}

{undef $all_latest_content $current_lang}

{/cache-block}

{undef $user_hash}
