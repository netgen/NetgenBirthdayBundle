<form enctype="multipart/form-data" method="post" id="edit-content" action={concat( "/content/edit/", $object.id, "/", $edit_version, "/", $edit_language|not|choose( concat( $edit_language, "/" ), '' ) )|ezurl}>
<div class="form-actions hide">
    <input type="hidden" name="DiscardConfirm" value="0" />
    <input type="hidden" name="MainNodeID" value="{$main_node_id}" />
    <input  type="submit" name="DiscardButton" />
    <input  type="submit" name="PublishButton" />
    <input type="hidden" name="ngMceItalicText" value="{"Italic"|i18n("dms/ajax/content_create")}">
</div>

<div class="row">
    <div class="col-lg-11 col-sm-10">

        <div class="box">
            <div class="box-header" data-original-title>
                <h2>{$class.name|d18n('dms/edit/forum_topic')}</h2>
            </div>
            <div class="box-content">

                {include uri="design:content/edit_validation.tpl"}

                <h3>{'Subject'|i18n('dms/edit/forum_topic')}</h3>

                <p>
                {attribute_edit_gui attribute=$object.data_map.subject}
                </p>

                <h3>{'Message'|i18n('dms/edit/forum_topic')}</h3>
                {attribute_edit_gui attribute=$object.data_map.message id="fmessage"}

                {let current_user=fetch( 'user', 'current_user' )
                     sticky_groups=ezini( 'ForumSettings', 'StickyUserGroupArray', 'forum.ini' )}

                    {section var=sticky loop=$sticky_groups}
                        {if $current_user.groups|contains($sticky)}
                            <h3>{'Sticky'|i18n('dms/edit/forum_topic')}</h3>
                            {attribute_edit_gui attribute=$object.data_map.sticky}
                        {/if}
                    {/section}
                {/let}
            </div>
        </div>
    </div>

    <div class="col-lg-1 col-sm-2">
        <div class="affix-wrapper">
            <ul class="actions-nav">
                <li>
                    <a href="#" onclick="ezpopmenu_submitForm( 'edit-content', null, 'PublishButton' ); return false;">
                        <i class="fa fa-check"></i>
                        <p>{"Save"|i18n( 'design/standard/content/edit' )}</p>
                    </a>
                    <a href="#" onclick="ezpopmenu_submitForm( 'edit-content', null, 'DiscardButton' ); return false;">
                        <i class="fa fa-times"></i>
                        <p>{"Discard"|i18n( 'design/standard/content/edit' )}</p>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>
</form>
