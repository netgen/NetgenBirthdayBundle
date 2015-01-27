<div class="row">
    <div class="col-lg-11 col-sm-10">
        {* message box *}
            {if and( is_set( $success_activate ), is_set( $errors_activate ) )}
            <div class="box-content alerts">
                {if $success_activate}
                <div class="alert alert-success">
                    <h2>{'The following users have been successfully activated:'|i18n( 'design/standard/user/register' )}</h2>
                    <ul>
                    {foreach $success_activate as $userid}
                        {def $object = fetch( content, object, hash( 'object_id', $userid ) )}
                        {if $object.status|eq( 1 )}
                            <li><a href={$object.main_node.url_alias|ezurl}>{$object.name|wash}</a></li>
                        {else}
                            <li>{$object.name|wash}</li>
                        {/if}
                        {undef $object}
                    {/foreach}
                    </ul>
                </div>
                {/if}
                {if $errors_activate}
                <div class="alert alert-danger">
                    <h2>{'Some users have not been activated'|i18n( 'design/standard/user/register' )}</h2>
                </div>
                {/if}
            </div>
            {elseif and( is_set( $success_remove ), is_set( $errors_remove ) )}
            <div class="box-content alerts">
                {if $success_remove}
                <div class="alert alert-success">
                    <h2>{'The following unactivated users have been successfully removed:'|i18n( 'design/standard/user/register' )}</h2>
                    <ul>
                    {foreach $success_remove as $name}
                        <li>{$name|wash}</li>
                    {/foreach}
                    </ul>
                </div>
                {/if}
                {if $errors_remove}
                <div class="alert alert-danger">
                    <h2>{'Some users have not been removed'|i18n( 'design/standard/user/register' )}</h2>
                </div>
                {/if}
            </div>
            {/if}

        {* message box end *}
        <div class="box">
            <div class="box-header" data-original-title>
                <h2><i class="fa fa-user"></i><span class="break"></span>{'Unactivated users (%users_count)'|i18n( 'design/standard/user/register',, hash( '%users_count', $unactivated_count ) )|upcase()}</h2>
                <div class="box-icon">
                    <a href={concat($node.url_alias, '#')|ezurl} class="btn-minimize"><i class="fa fa-chevron-up"></i></a>
                </div>
            </div>

            <div class="box-content">
                {if $unactivated_count}
                    {def $uri = $module.functions.unactivated.uri}
                    <form name="activations" method="post" action={$uri|ezurl}>
                        <table class="table table-striped table-bordered bootstrap-datatable datatable">
                            <tr>
                                <th>{*<img src={'toggle-button-16x16.gif'|ezimage} width="16" height="16" alt="{'Toggle selection'|i18n( 'design/admin/user' )}" onclick="ezjs_toggleCheckboxes( document.activations, 'DeleteIDArray[]' ); return false;"/>*}&nbsp;</th>
                                <th>&nbsp;</th>
                                <th>{'Title'|i18n( 'dms/full/folder' )}</th>
                                <th{cond( $sort_field|eq( 'login' ), concat( ' class="sort-', $sort_order, '"' ), '' )}><a href={concat(
                                    $uri, '/login/', cond( and( $sort_field|eq( 'login' ), $sort_order|eq( 'asc' ) ), 'desc', 'asc' ) )|ezurl}>{'Login'|i18n( 'dms/login' )}</a></th>
                                <th{cond( $sort_field|eq( 'email' ), concat( ' class="sort-', $sort_order, '"' ), '' )}><a href={concat(
                                    $uri, '/email/', cond( and( $sort_field|eq( 'email' ), $sort_order|eq( 'asc' ) ), 'desc', 'asc' ) )|ezurl}>{'E-mail'|i18n( 'dms/user/profile' )}</a></th>
                                <th{cond( $sort_field|eq( 'time' ), concat( ' class="sort-', $sort_order, '"' ), '' )}><a href={concat(
                                    $uri, '/time/', cond( and( $sort_field|eq( 'time' ), $sort_order|eq( 'asc' ) ), 'desc', 'asc' ) )|ezurl}>{'Registration date'|i18n( 'design/standard/user/register' )}</a></th>
                            </tr>

                            {def $number_of_items=50}

                            {foreach $unactivated_users as $user_index => $user sequence array( 'bglight', 'bgdark' ) as $style}
                            <tr class="{$style}">
                                <td><input type="checkbox" name="DeleteIDArray[]" id="delete-{$user.contentobject_id}" value="{$user.contentobject_id}" /></td>
                                <td><label for="delete-{$user.contentobject_id}">{$user_index|inc()}</label></td>
                                <td><label for="delete-{$user.contentobject_id}">{$user.contentobject.name|wash()}</label></td>
                                <td><label for="delete-{$user.contentobject_id}">{$user.login|wash()}</label></td>
                                <td><label for="delete-{$user.contentobject_id}">{$user.email|wash()}</label></td>
                                <td><label for="delete-{$user.contentobject_id}">{$user.account_key.time|l10n( 'shortdate' )}</label></td>
                            </tr>
                            {/foreach}

                        </table>

                        {include name=navigator
                                 uri='design:navigator/google.tpl'
                                 page_uri=concat( '/user/unactivated/', $sort_field, '/', $sort_order )
                                 item_count=$unactivated_count
                                 view_parameters=$view_parameters
                                 item_limit=$number_of_items}

                        <input class="btn btn-large btn-success" type="submit" name="ActivateButton" value="{'Activate selected users'|i18n( 'design/standard/user/register' )}" title="{'Activate selected users.'|i18n( 'design/standard/user/register' )}" />
                        <input class="btn btn-large btn-danger" type="submit" name="RemoveButton" value="{'Remove selected users'|i18n( 'design/standard/user/register' )}" title="{'Remove selected users'|i18n( 'design/standard/user/register' )}" />
                    </form>
                    {undef $uri}
                {else}
                    <div class="block">
                        <p>{'There are no unactivated users'|i18n( 'design/standard/user/register' )}</p>
                    </div>
                {/if}

            </div>
        </div>
    </div>

    <div class="col-lg-1 col-sm-2">
        <div class="affix-wrapper">
            <ul class="actions-nav">
                <li>
                    <a href={'Users'|ezurl()}>
                        <i class="fa fa-group"></i>
                        <p>{"Active users"|i18n("dms/full/folder")}</p>
                    </a>
                </li>
            </ul>
        </div>
    </div>

</div>
