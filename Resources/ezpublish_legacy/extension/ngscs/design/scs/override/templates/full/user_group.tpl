{set-block variable=$action_items}
{if $node.can_edit}
    <li>
        <a href="#" onclick="ezpopmenu_submitForm( 'create-user' ); return false;">
            <i class="fa fa-plus-circle"></i>
            <p>{"Create user"|i18n("dms/full/user")}</p>
        </a>
        <form style="display: none" id="create-user" method="post" action={"/content/action"|ezurl}>

            <input type="hidden" value="{$node.node_id}" name="NodeID">

            <input type="hidden" value="4" name="ClassID">
            <input type="hidden" value="" name="NewButton">
            <input type="hidden" value="{$node.object.current_language}" name="ContentLanguageCode">

        </form>
    </li>
{/if}
<li>
    <a href={'user/unactivated'|ezurl()}>
        <i class="fa fa-exclamation-triangle"></i>
        <p>{"View unactivated users"|i18n("dms/full/user")}</p>
    </a>
</li>
{/set-block}

{set scope=global persistent_variable=hash('action_items', $action_items, 'full_view_scripts_bottom', array('ezpopupmenu.js'))}

<div class="row">
    <div class="col-lg-12">
        <div class="box">
            <div class="box-header" data-original-title>
                <h2><i class="fa fa-user"></i><span class="break"></span>{$node.object.data_map.name.content|wash()|d18n( 'dms/full/folder' )|upcase}</h2>
            </div>

            <div class="box-content">

                {if $node.object.data_map.description.has_content}
                    <div class="attribute-long"> <p>This is description attribute container</p>
                        {attribute_view_gui attribute=$node.object.data_map.description}
                    </div>
                {/if}

                {if is_unset( $versionview_mode )}
                    {def $page_limit=10
                         $list_items=array()
                         $list_count=0}

                    {if or( $view_parameters.day, $view_parameters.month, $view_parameters.year )}
                        {def $time_filter=array( and,
                                                array( 'published', '>=',
                                                       maketime( 0, 0, 0,
                                                                 $view_parameters.month, cond( $view_parameters.day, $view_parameters.day, 1 ), $view_parameters.year ) ),
                                                array( 'published', '<=',
                                                       maketime( 23, 59, 59,
                                                                 cond( $view_parameters.day, $view_parameters.month, $view_parameters.month|inc ), cond( $view_parameters.day, $view_parameters.day, 0 ), $view_parameters.year ) ) )}
                        {set list_items=fetch_alias( children, hash( parent_node_id, $node.node_id,
                                                                     offset, $view_parameters.offset,
                                                                     attribute_filter, $time_filter,
                                                                     sort_by, $node.sort_array,
                                                                     limit, $page_limit,
                                                                     class_filter_type, 'include',
                                                                     class_filter_array, array( 'user_group', 'user' ) ) )
                             list_count=fetch_alias( children_count, hash( parent_node_id, $node.node_id ) )}
                        {undef $time_filter}
                    {else}
                        {set list_items=fetch_alias( children, hash( parent_node_id, $node.node_id,
                                                                     offset, $view_parameters.offset,
                                                                     sort_by, $node.sort_array,
                                                                     limit, $page_limit,
                                                                     class_filter_type, 'include',
                                                                     class_filter_array, array( 'user_group','user' ) ) )}
                        {set list_count=fetch_alias( children_count, hash( parent_node_id, $node.node_id ) )}
                    {/if}

                    {def $has_user=false}
                    {foreach $list_items as $child}
                        {if $child.object.class_identifier|eq('user')}
                            {set $has_user=true}
                            {break}
                        {/if}
                    {/foreach}
                        <table class="table table-striped table-bordered clickable">
                            <thead>
                                <tr>
                                    <th>{"Title"|i18n( 'dms/full/folder' )}</th>
                                    <th>{"Type"|i18n( 'dms/full/folder' )}</th>
                                    <th>{"Modification date"|i18n( 'dms/full/folder' )}</th>
                                    {if $has_user|eq(true)}
                                    <th>{"All content / Last 30 days / Last 7 days"|i18n( 'dms/full/folder' )}</th>
                                    <th>{"All forum topics / Last 30 days / Last 7 days"|i18n( 'dms/full/folder' )}</th>
                                    <th>{'Status'|i18n( 'dms/full/user' )}</th>
                                    {/if}
                                </tr>
                            </thead>

                            {def $user_all_content_count = ''}
                            {def $user_last_content_count = ''}
                            {def $user_last_week_content_count = ''}
                            {def $user_all_forum_count = ''}
                            {def $user_last_forum_count = ''}
                            {def $user_last_week_forum_count = ''}
                            {def $current_date = currentdate()}
                            {def $thirty_days = 2592000}
                            {def $seven_days = 604800}
                            {def $last_period = sub($current_date, $thirty_days)}
                            {def $last_week = sub($current_date, $seven_days)}

                            <tbody>
                                {foreach $list_items as $child}
                                    {if and($has_user|eq(true), $child.object.class_identifier|eq('user'))}
                                    {set $user_all_content_count = fetch( 'content', 'tree_count', hash( 'parent_node_id',   ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                                                                            'class_filter_type', include,
                                                                            'class_filter_array', array('dossier_ap', 'dossier_ld','dossier_co', 'article_amended_ld', 'article_ld', 'file', 'private_file'),
                                                                            'attribute_filter', array( array( 'owner', '=', $child.contentobject_id ) )
                                                                            ) )}
                                    {set $user_last_content_count = fetch( 'content', 'tree_count', hash( 'parent_node_id',   ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                                                                            'class_filter_type', include,
                                                                            'class_filter_array', array('dossier_ap', 'dossier_ld','dossier_co', 'article_amended_ld', 'article_ld', 'file', 'private_file'),
                                                                            'attribute_filter', array( 'and', array( 'owner', '=', $child.contentobject_id ), array( 'published', 'between', array( $last_period, $current_date ) ) )
                                                                            ) )}
                                    {set $user_last_week_content_count = fetch( 'content', 'tree_count', hash( 'parent_node_id',   ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                                                                            'class_filter_type', include,
                                                                            'class_filter_array', array('dossier_ap', 'dossier_ld','dossier_co', 'article_amended_ld', 'article_ld', 'file', 'private_file'),
                                                                            'attribute_filter', array( 'and', array( 'owner', '=', $child.contentobject_id ), array( 'published', 'between', array( $last_week, $current_date ) ) )
                                                                            ) )}
                                    {set $user_all_forum_count = fetch( 'content', 'tree_count', hash( 'parent_node_id',   ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                                                                            'class_filter_type', include,
                                                                            'class_filter_array', array('forum_reply', 'forum_topic'),
                                                                            'attribute_filter', array( array( 'owner', '=', $child.contentobject_id ) )
                                                                            ) )}
                                    {set $user_last_forum_count = fetch( 'content', 'tree_count', hash( 'parent_node_id',   ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                                                                            'class_filter_type', include,
                                                                            'class_filter_array', array('forum_reply', 'forum_topic'),
                                                                            'attribute_filter', array( 'and', array( 'owner', '=', $child.contentobject_id ), array( 'published', 'between', array( $last_period, $current_date ) ) )
                                                                            ) )}
                                    {set $user_last_week_forum_count = fetch( 'content', 'tree_count', hash( 'parent_node_id',   ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                                                                            'class_filter_type', include,
                                                                            'class_filter_array', array('forum_reply', 'forum_topic'),
                                                                            'attribute_filter', array( 'and', array( 'owner', '=', $child.contentobject_id ), array( 'published', 'between', array( $last_week, $current_date ) ) )
                                                                            ) )}
                                    {/if}
                                    <tr>
                                        <td width="25%"><a href={$child.url_alias|ezurl}>{$child.name|wash}</a></td>
                                        <td>{$child.object.class_name|d18n('dms/full/user')}</td>
                                        <td>{$child.object.modified|l10n('shortdate')}</td>
                                        {if $has_user|eq(true)}
                                        <td>{if $child.object.class_identifier|eq('user')}{$user_all_content_count} / {$user_last_content_count} / {$user_last_week_content_count}{else}-{/if}</td>
                                        <td>{if $child.object.class_identifier|eq('user')}{$user_all_forum_count} / {$user_last_forum_count} / {$user_last_week_forum_count}{else}-{/if}</td>
                                        <td>{if $child.object.class_identifier|eq('user')}{if $child.object.data_map.user_account.content.is_enabled}{'Enabled'|i18n( 'dms/full/user' )}{else}{'Disabled'|i18n( 'dms/full/user' )}{/if}{else}-{/if}</td>
                                        {/if}
                                    </tr>
                                {/foreach}
                                <tr>
                                </tr>
                            </tbody>
                        </table>
                    {include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri=$node.url_alias
                     item_count=$list_count
                     view_parameters=$view_parameters
                     item_limit=$page_limit}

                    {undef $page_limit $list_items $list_count}
                {/if}
            </div>
        </div>
    </div><!--/col-->

</div><!--/row-->
