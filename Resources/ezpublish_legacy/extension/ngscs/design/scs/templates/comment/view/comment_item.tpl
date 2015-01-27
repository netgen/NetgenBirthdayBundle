{def $owner = fetch( content, object, hash('object_id', $comment.user_id) )}
{def $owner_map = $owner.data_map}

<div class="discussions">
<ul class="ezcom-view-comment{if $comment.user_id} uoid{$comment.user_id}{/if}">
<li class="ezcom-view-comment-item clearfix">
    <input type="hidden" name="CommentID" value="{$comment.id}" />
    <div class="author">
        {if $owner_map.image.has_content}
            {attribute_view_gui attribute=$owner_map.image image_class='dms_userthumbnail'}
        {else}
            <img src="/share/icons/crystal-admin/32x32/apps/personal.png" alt="avatar" />
        {/if}
    </div>
    <div class="name">
        {if $comment.url|eq( '' )}
            {$comment.name|wash}
        {else}
            <a href="{$comment.url|wash}">
                {$comment.name|wash}
            </a>
        {/if}
    </div>

    <div class="date ezcom-comment-time">
        {$comment.created|l10n( 'shortdatetime' )}
    </div>

    <div class="message ezcom-comment-body">
        <p>{$comment.text|wash|nl2br}</p>
        {if or( $can_edit, $can_self_edit )}
            {if and( $can_self_edit, not( $can_edit ) )}
                {def $displayAttribute=$user_display_limit_class}
            {else}
                {def $displayAttribute=''}
            {/if}
            <a class="btn btn-warning" href={concat( '/comment/edit/', $comment.id )|ezurl}>
                {'Edit'|i18n('ezcomments/comment/view')}
            </a>
            {undef $displayAttribute}
        {/if}
    </div>

</li>
</ul>
</div>
