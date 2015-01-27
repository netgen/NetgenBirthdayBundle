{def $remove_comments_allowed = fetch(user, has_access_to, hash(module, comment, function, removecomments))}
{def $edit_allowed = fetch(user, has_access_to, hash(module, comment, function, edit))}

{def $shortcut_node = fetch(content, node, hash(node_id, 156))}

<form action={'comment/list'|ezurl} method="post" name="commentlist">

<div class="row">
    <div class="{if and($edit_allowed, ezini( 'RegionalSettings', 'Locale', 'site.ini' ))|ne('eng-GB')}col-lg-11 col-sm-10{else}col-lg-12{/if}">

        <div class="box">
            <div class="box-header" data-original-title>
                <h2><i class="fa fa-comments"></i><span class="break"></span>{'Comments list'|i18n( 'ezcomments/comment/list' )}</h2>
            </div>

            <div class="box-content">
                <table class="table table-striped clickable">
                    <tbody>
                        <tr>
                            {if $remove_comments_allowed}<th class="tight"></th>{/if}
                            <th>{'Comment'|i18n('ezcomments/comment/list')}</th>
                            <th>{'Node'|i18n('ezcomments/comment/list')}</th>
                            <th>{'Modified'|i18n('ezcomments/comment/list')}</th>
                            <th style="text-align:right">{'IP address'|i18n('ezcomments/comment/list')}</th>
                            {if $edit_allowed}<th class="tight">&nbsp;</th>{/if}
                        </tr>

                        {def $comments_count = fetch(comment, comment_count)}
                        {def $comments = fetch(comment, comment_list_by_content_list, hash(offset, $view_parameters.offset, length, 10))}

                        {foreach $comments as $comment sequence array('bglight', 'bgdark') as $sequence}
                            <tr class="{$sequence}">
                                {if $remove_comments_allowed}<td><input type="checkbox" value="{$comment.id}" name="DeleteIDArray[]" /></td>{/if}
                                <td>{$comment.text|wash|shorten(200)}</td>
                                <td><a href={concat($comment.contentobject.main_node.url_alias,"#comments")|ezurl}>{$comment.contentobject.main_node.name|wash}</a></td>
                                <td>{$comment.modified|l10n(shortdatetime)}</td>
                                <td class="number" align="right">{$comment.ip}</td>
                                {if $edit_allowed}<td><a href={concat('comment/edit/', $comment.id)|ezurl}><img src={'edit.gif'|ezimage} alt="{'Edit comment'|i18n('ezcomments/comment/list')}" /></a></td>{/if}
                            </tr>
                        {/foreach}
                    </tbody>
                </table>

                {if and($comments_count|gt(0), $remove_comments_allowed)}
                    <div class="controls">
                        <input type="submit" value="{'Remove selected'|i18n('ezcomments/comment/list')}" name="RemoveCommentsButton" class="btn btn-danger" />
                    </div>
                {/if}

                {include name=navigator
                    uri='design:navigator/google.tpl'
                    page_uri='comment/list'
                    item_count=$comments_count
                    view_parameters=$view_parameters
                    item_limit=10}

            </div>
        </div>
    </div>
    {if $edit_allowed}
    <div class="col-lg-1">
        {include uri='design:parts/modal_buttons.tpl' node=$shortcut_node}
    </div>
    {/if}
</div>
</form>
