<form enctype="multipart/form-data" method="post" id="edit-content" action={concat( "/content/edit/", $object.id, "/", $edit_version, "/", $edit_language|not|choose( concat( $edit_language, "/" ), '' ) )|ezurl}>
<div class="form-actions hide">
    <input type="hidden" name="DiscardConfirm" value="0" />
    <input type="hidden" name="MainNodeID" value="{$main_node_id}" />
    <input type="hidden" name="ngMceItalicText" value="{"Italic"|i18n("dms/ajax/content_create")}">
</div>

<div class="row">
    <div class="col-lg-11 col-sm-10">

        <div class="box">
            <div class="box-header" data-original-title>
                <h2>{$class.name|d18n('dms/edit/forum_reply')}</h2>
            </div>
            <div class="box-content">

                {include uri="design:content/edit_validation.tpl"}

                <h3>{'Subject'|i18n('dms/edit/forum_reply')}</h3>

                {def $pnode = fetch('content','node', hash('node_id', $main_node_id ))}
                <p>{attribute_edit_gui attribute=$object.data_map.subject value_if_empty=concat( 'Re: ', $pnode.name )|wash( xhtml )}</p>
                {undef $pnode}


                <h3>{'Message'|i18n('dms/edit/forum_reply')}</h3>
                {attribute_edit_gui attribute=$object.data_map.message id="fmessage"}

            </div>
        </div>
        <div class="buttonblock">
            <input type="hidden" name="MainNodeID" value="{$main_node_id}" />

            <input class="btn cancel" type="submit" name="DiscardButton" value="{"Cancel"|i18n( 'dms/edit/forum_reply' )}" />
            <input class="btn btn-primary save" type="submit" name="PublishButton" value="{"Submit"|i18n( 'dms/edit/forum_reply' )}" />

            <input type="hidden" name="RedirectIfDiscarded" value={'ngajaxcrud/status'|ezurl} />
            <input type="hidden" name="RedirectURIAfterPublish" value={'ngajaxcrud/status'|ezurl} />
            <input type='hidden' name='ngajaxcrud_ContentObjectID' value="{$object.id}" />
        </div>
    </div>
</div>
</form>
