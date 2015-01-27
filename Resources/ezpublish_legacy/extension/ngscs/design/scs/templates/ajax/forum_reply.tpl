<div class="content-view-line reply_container {$node.object.content_class.identifier}" id="obid-{$node.object.id}" data-id="{$node.object.id}">
    {def
        $owner = $node.object.owner
        $owner_map = $owner.data_map
        $owner_id = $node.object.owner.id}
    <div class="author">
        {if $owner_map.image.has_content}
            {attribute_view_gui attribute=$owner_map.image image_class='dms_userthumbnail_reply'}
        {else}
            <img src="/share/icons/crystal-admin/32x32/apps/personal.png" alt="avatar" />
        {/if}
    </div>
    <div class="name">
        {$owner.name|wash}{if is_set( $owner_map.title )}, {$owner_map.title.content|wash}{/if}
        {if is_set( $owner_map.location )}, {"Location"|i18n( "dms/full/forum_topic" )}: {$owner_map.location.content|wash}{/if}
        {foreach $node.object.author_array as $author}
            {if eq($owner_id,$author.contentobject_id)|not()}
                , {"Moderated by"|i18n( "dms/full/forum_topic" )}: {$author.contentobject.name|wash}
            {/if}
        {/foreach}: {attribute_view_gui attribute=$node.object.data_map.subject}
    </div>
    <div class="date">{$node.object.published|l10n(datetime)}</div>
    <div class="message">
        {if $node.object.can_edit}
            <div class="line-buttons float-break pull-right">
                <form id="form-actions" action={"/content/action"|ezurl} method="post">
                    <input class="btn" type="submit" name="EditButton" value="{'Edit'|i18n( 'dms/ajax' )}" />

                    <input type="hidden" name="ContentObjectID" value="{$node.object.id}">
                    <input type="hidden" name="ContentNodeID" value="{$node.node_id}">

                    <input type="hidden" name="ContentObjectLanguageCode" value="{ezini( 'RegionalSettings', 'ContentObjectLocale', 'site.ini' )}">

                    <input type="hidden" name="RedirectURIAfterRemove" value="{'ngajaxcrud/status'|ezurl}">
                    <input type="hidden" name="RedirectIfCancel" value="{'ngajaxcrud/status'|ezurl}">
                    <input type="hidden" name="CancelURI" value="{'ngajaxcrud/status'|ezurl}">


                </form>
            </div>
        {/if}
        {attribute_view_gui attribute=$node.object.data_map.message}
    </div>
    {undef $owner $owner_map $owner_id}
</div>
