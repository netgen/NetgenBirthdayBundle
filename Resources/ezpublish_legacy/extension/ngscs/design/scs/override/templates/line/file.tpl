<div class="col-lg-4 col-md-6 file-item">
    <div class="file-item-inner">
        <a onclick="ezpopmenu_submitForm( 'removeattachment{$node.contentobject_id}' ); return false;" alt="{"Remove this attachment"|i18n('dms/line/file')}" title="{"Remove this attachment"|i18n('dms/line/file')}">
            <i class="fa fa-times pull-right"></i>
        </a>
        <div class="class-file">
            {if $node.data_map.description.has_content}
                <div class="attribute-short">
                {attribute_view_gui attribute=$node.data_map.description}
                </div>
            {/if}
            <div class="attribute-file">
                <p>{attribute_view_gui attribute=$node.data_map.file icon_size='large' icon_title=$node.name}</p>
            </div>
        </div>

        <div class="form-actions hide">
            <form method="post" action={"content/action"|ezurl} id="removeattachment{$node.contentobject_id}">
                <input type="hidden" name="ContentNodeID"  value="{$node.main_node_id}" />
                <input type="hidden" name="ContentObjectID" value="{$node.contentobject_id}" />
                <input type="hidden" name="ActionRemove" value="" />
                <input type="hidden" name="HideRemoveConfirmation" value="1" />
                <input type="hidden" name="RedirectURIAfterRemove" value="{concat($node.parent.url_alias, '#attachments')}" />
                <input type="hidden" name="SupportsMoveToTrash" value="1" />
                <input type="hidden" name="MoveToTrash" value="1" />
            </form>
        </div>
    </div>
</div>
