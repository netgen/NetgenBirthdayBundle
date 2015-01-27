{set scope=global persistent_variable=hash('full_view_scripts_bottom', array('ezpopupmenu.js'))}

{if $node.data_map.user_account.content.is_enabled}
    <span class="label label-success">{"Enabled"|i18n("dms/full/user")}</span>
{else}
    <span class="label label-danger">{"Disabled"|i18n("dms/full/user")}</span>
{/if}

<h1>{$node.object.name|wash}</h1>

<div class="row">
    <div class="col-lg-11 col-sm-10">
        <div class="row">

            <div class="col-lg-9 col-sm-8">
                <div class="box">
                    <div class="box-header">
                        <h2><i class="fa fa-user"></i><span class="break"></span>{'User Info'|i18n('dms/full/user')}</h2>
                    </div>
                    <div class="box-content">

                        <p>{"Last change"|i18n("dms/full/user")}: <b>{$node.object.modified|datetime( 'custom', '%d/%m/%Y %H:%i' )}</b></p>
                        <p>{"Modified by"|i18n("dms/full/user")}: <b>{$node.object.current.creator.name|wash}</b></p>
                    </div>
                </div>
            </div>


        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="box">
                    <div class="box-header">
                        <h2><i class="fa fa-info-circle"></i><span class="break"></span>{"Info"|i18n( 'dms/user/profile' )}</h2>
                        <div class="box-icon">
                            <a class="btn-minimize" href="/Users/Members#"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="box-content">
                        <table class="table table-striped table-bordered bootstrap-datatable user-full" border="0" cellpadding="3" cellspacing="3" width="100%">
                            <tr>
                                <td width="20%">{"Username"|i18n("dms/user/profile")}: </td><td><b>{$node.data_map.user_account.content.login|wash}</b></td>
                            </tr>
                            <tr>
                                <td width="20%">{"E-mail"|i18n("dms/user/profile")}: </td><td><b>{$node.data_map.user_account.content.email|wash(email)}</b></td>
                            </tr>
                            <tr>
                                <td width="20%">{"Name"|i18n("dms/user/profile")}: </td><td>{attribute_view_gui attribute=$node.data_map.first_name} {attribute_view_gui attribute=$node.data_map.last_name}</td>
                            </tr>
                            <tr>
                                <td width="20%">{"Signature"|i18n("dms/user/profile")}: </td><td>{attribute_view_gui attribute=$node.data_map.signature}</td>
                            </tr>
                            <tr>
                                <td width="20%">{"Image"|i18n("dms/user/profile")}: </td><td>{attribute_view_gui attribute=$node.data_map.image}</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="box">
                    <div class="box-header">
                        <h2><i class="fa fa-bar-chart-o"></i><span class="break"></span>{"Statistics"|i18n( 'dms/user/profile' )}</h2>
                        <div class="box-icon">
                            <a class="btn-minimize" href="/Users/Members#"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="box-content">
                        {def $all_content_count = fetch( 'content', 'tree_count', hash( 'parent_node_id',   ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                        'class_filter_type', include,
                        'class_filter_array', array('dossier_ap', 'dossier_ld','dossier_co', 'article_amended_ld', 'article_ld'),
                        'attribute_filter', array( array( 'owner', '=', $node.contentobject_id ) )
                        ) )}
                        {def $all_discussions_count = fetch( 'content', 'tree_count', hash( 'parent_node_id',   ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                        'class_filter_type', include,
                        'class_filter_array', array('forum_reply', 'forum_topic'),
                        'attribute_filter', array( array( 'owner', '=', $node.contentobject_id ) )
                        ) )}
                        {def $current_date = currentdate()}
                        {def $thirty_days = 2592000}
                        {def $seven_days = 604800}
                        {def $last_period = sub($current_date, $thirty_days)}
                        {def $last_week = sub($current_date, $seven_days)}

                        {def $last_content_count = fetch( 'content', 'tree_count', hash( 'parent_node_id',   ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                        'class_filter_type', include,
                        'class_filter_array', array('dossier_ap', 'dossier_ld','dossier_co', 'article_amended_ld', 'article_ld'),
                        'attribute_filter', array( 'and', array( 'owner', '=', $node.contentobject_id ), array( 'published', 'between', array( $last_period, $current_date ) ) )
                        ) )}
                        {def $last_discussions_count = fetch( 'content', 'tree_count', hash( 'parent_node_id',   ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                        'class_filter_type', include,
                        'class_filter_array', array('forum_reply', 'forum_topic'),
                        'attribute_filter', array( 'and', array( 'owner', '=', $node.contentobject_id ), array( 'published', 'between', array( $last_period, $current_date ) ) )
                        ) )}

                        {def $last_week_content_count = fetch( 'content', 'tree_count', hash( 'parent_node_id',   ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                        'class_filter_type', include,
                        'class_filter_array', array('dossier_ap', 'dossier_ld','dossier_co', 'article_amended_ld', 'article_ld'),
                        'attribute_filter', array( 'and', array( 'owner', '=', $node.contentobject_id ), array( 'published', 'between', array( $last_week, $current_date ) ) )
                        ) )}
                        {def $last_week_discussions_count = fetch( 'content', 'tree_count', hash( 'parent_node_id',   ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                        'class_filter_type', include,
                        'class_filter_array', array('forum_reply', 'forum_topic'),
                        'attribute_filter', array( 'and', array( 'owner', '=', $node.contentobject_id ), array( 'published', 'between', array( $last_week, $current_date ) ) )
                        ) )}

                        {def $last_week_discussions = fetch( 'content', 'tree', hash( 'parent_node_id',   ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                        'class_filter_type', include,
                        'class_filter_array', array('forum_reply', 'forum_topic'),
                        'attribute_filter', array( 'and', array( 'owner', '=', $node.contentobject_id ), array( 'published', 'between', array( $last_week, $current_date ) ) )
                        ) )}


                        <table class="table table-striped table-bordered bootstrap-datatable user-full" border="0" cellpadding="3" cellspacing="3" width="100%">
                            <tr>
                                <td width="20%">{"All content created"|i18n("dms/user/profile")}: </td>
                                <td width="5%"><b>{$all_content_count}</b></td>
                                <td width="30%">{"Content created in the last 30 days"|i18n("dms/user/profile")}:</td>
                                <td width="5%"><b>{$last_content_count}</b></td>
                                <td width="30%">{"Content created in the last 7 days"|i18n("dms/user/profile")}:</td>
                                <td width="10%"><b>{$last_week_content_count}</b></td>
                            </tr>
                            <tr>
                                <td width="20%">{"All forum discussions"|i18n("dms/user/profile")}:</td>
                                <td width="5%"><b>{$all_discussions_count}</b></td>
                                <td width="30%">{"Forum discussions created in the last 30 days"|i18n("dms/user/profile")}:</td>
                                <td width="5%"><b>{$last_discussions_count}</b></td>
                                <td width="30%">{"Forum discussions created in the last 7 days"|i18n("dms/user/profile")}:</td>
                                <td width="10%"><b>{$last_week_discussions_count}</b></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="box">
                    <div class="box-header">
                        <h2><i class="fa fa-comments"></i><span class="break"></span>{"Latest discussions"|i18n( 'dms/user/profile' )}</h2>
                        <div class="box-icon">
                            <a class="btn-minimize" href="/Users/Members#"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="box-content">
                        {def $latest_discussions = fetch( 'content', 'tree', hash( 'parent_node_id',   ezini('DMSSettings', 'DiscussionsNodeID', 'dms.ini'),
                                                       'limit',            20,
                                                       'class_filter_type', include,
                                                       'class_filter_array', array('forum_reply', 'forum_topic'),
                                                       'main_node_only',   true(),
                                                       'sort_by',          array( 'modified_subnode', false() ),
                                                       'attribute_filter', array( array( 'owner', '=', $node.contentobject_id ) ) ) )}

                        {if $latest_discussions}

                        <table class="table table-striped table-bordered bootstrap-datatable list" cellpadding="0" cellspacing="0" border="0" width="100%">
                            <thead>
                                <tr>
                                    <th>{'Name'|i18n( 'dms/user/profile' )}</th>
                                    <th>{'Action'|i18n( 'dms/user/profile' )}</th>
                                    <th>{'Type'|i18n( 'dms/user/profile' )}</th>
                                    <th>{'Time'|i18n( 'dms/user/profile' )}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach $latest_discussions as $latest_node sequence array( 'bglight', 'bgdark' ) as $style}
                                    <tr class="{$style}">
                                        <td>
                                            {if $latest_node.class_identifier|eq('forum_reply')}
                                            <a href={concat("content/view/full/",$latest_node.parent.node_id)|ezurl} title="{$latest_node.name|wash()}">{$latest_node.name|shorten('90')|wash()}</a>
                                            {else}
                                            <a href={concat("content/view/full/",$latest_node.node_id)|ezurl} title="{$latest_node.name|wash()}">{$latest_node.name|shorten('90')|wash()}</a>
                                            {/if}
                                        </td>
                                        <td>
                                            {if $latest_node.contentobject_version|eq(1)}
                                            {'Created'|i18n( 'dms/user/profile' )}
                                            {else}
                                            {'Modified'|i18n( 'dms/user/profile' )}
                                            {/if}
                                        </td>
                                        <td>
                                            {$latest_node.class_name|d18n( 'dms/user/profile' )}
                                        </td>
                                        <td>
                                            {$latest_node.object.modified|l10n('shortdate')}
                                        </td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>

                        {else}

                        <p>{"User's latest discussion list is empty."|i18n( 'dms/user/profile' )}</p>

                        {/if}
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="box">
                    <div class="box-header">
                        <h2><i class="fa fa-clock-o"></i><span class="break"></span>{"Latest activity"|i18n( 'dms/user/profile' )}</h2>
                        <div class="box-icon">
                            <a class="btn-minimize" href="/Users/Members#"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="box-content">
                        {def $latest_content = fetch( 'content', 'tree', hash( 'parent_node_id',   ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                        'limit',            20,
                        'class_filter_type', include,
                        'class_filter_array', array('dossier_ap', 'dossier_ld','dossier_co', 'article_amended_ld', 'article_ld', 'file', 'private_file'),
                        'main_node_only',   true(),
                        'sort_by',          array( 'modified', false() ),
                        'attribute_filter', array( array( 'owner', '=', $node.contentobject_id ) ) ) )
                        $current_lang = ''}

                        {if $latest_content}

                            <table class="table table-striped table-bordered bootstrap-datatable list" cellpadding="0" cellspacing="0" border="0" width="100%">
                                <thead>
                                <tr>
                                    <th>{'Name'|i18n( 'dms/user/profile' )}</th>
                                    <th>{'Action'|i18n( 'dms/user/profile' )}</th>
                                    <th>{'Type'|i18n( 'dms/user/profile' )}</th>
                                    <th>{'Time'|i18n( 'dms/user/profile' )}</th>
                                    <th class="tight"></th>
                                </tr>
                                </thead>
                                <tbody>
                                {foreach $latest_content as $latest_node sequence array( 'bglight', 'bgdark' ) as $style}
                                    {set $current_lang = $latest_node.object.current.contentobject.current_language}
                                    <tr class="{$style}">
                                        <td>
                                            <a href={concat("content/view/full/",$latest_node.node_id)|ezurl} title="{$latest_node.name|wash()}">{$latest_node.name|shorten('90')|wash()}</a>
                                        </td>
                                        <td>
                                            {if $latest_node.contentobject_version|eq(1)}
                                                {'Created'|i18n( 'dms/user/profile' )}
                                            {else}
                                                {'Modified'|i18n( 'dms/user/profile' )}
                                            {/if}
                                        </td>
                                        <td>
                                            {$latest_node.class_name|d18n( 'dms/user/profile' )}
                                        </td>
                                        <td>
                                            {$latest_node.object.modified|l10n('shortdate')}
                                        </td>
                                    </tr>
                                    {set $current_lang = ''}
                                {/foreach}
                                </tbody>
                            </table>

                        {else}

                            <p>{"User's latest content list is empty."|i18n( 'dms/user/profile' )}</p>

                        {/if}
                    </div>
                </div>
            </div>
        </div>

    </div>

    <div class="col-lg-1 col-sm-2">
        <div class="affix-wrapper">
            <ul class="actions-nav">
                <li>
                    <a onclick="ezpopmenu_submitForm( 'edit' ); return false;" href="#">
                    <i  class="fa fa-pencil"></i>
                    <p>{"Edit"|i18n("dms/full/user")}</p>
                    </a>
                    <form method="post" action="{"/content/action"|ezurl(no))}" id="edit">
                        <input type="hidden" name="NodeID" value="{$node.node_id}" />
                        <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                        <input type="hidden" name="EditButton" value="" />
                        <input type="hidden" name="ContentObjectLanguageCode" value="{$node.object.current_language}" />
                    </form>
                </li>

                <li>
                    <a onclick="ezpopmenu_submitForm( 'move' ); return false;" href="#">
                    <i class="fa fa-arrows"></i>
                    <p>{"Move"|i18n("dms/full/user")}</p>
                    </a>
                    <form method="post" action="{"/content/action"|ezurl(no))}" id="move">
                        <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
                        <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                        <input type="hidden" name="ContentObjectLanguageCode" value="{$node.object.current_language}" />
                        <input type="hidden" name="MoveNodeButton" value="Move" />
                        <input type="hidden" name="SelectedNodeIDArray[]" value="12" />
                    </form>
                </li>
                <li>
                    <a onclick="ezpopmenu_submitForm( 'status' ); return false;" href="#">
                        <i class="fa fa-key"></i>
                        {if $node.data_map.user_account.content.is_enabled}
                            <p>{"Disable user"|i18n("dms/full/user")}</p>
                        {else}
                            <p>{"Enable user"|i18n("dms/full/user")}</p>
                        {/if}
                    </a>

                    <form method="post" action={concat("user/setting/",$node.object.id)|ezurl} id="status">
                        <input type="hidden" name="user_account_status" value="{if $node.data_map.user_account.content.is_enabled}0{else}1{/if}" />
                        <input type="hidden" name="UpdateSettingButton" value="" />
                        <input style="display:none" type="checkbox" name="is_enabled" {if $node.data_map.user_account.content.is_enabled|not}checked="checked"{/if} />
                    </form>
                </li>
            </ul>
        </div>
    </div>
</div>


