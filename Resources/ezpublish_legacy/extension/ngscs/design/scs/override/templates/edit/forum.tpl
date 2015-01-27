<div class="line-wrapper">
<h1>{$class.name|d18n('dms/edit/forum_topic')}</h1>
<input type="hidden" name="ngMceItalicText" value="{"Italic"|i18n("dms/ajax/content_create")}">
<form enctype="multipart/form-data" method="post" action={concat( "/content/edit/", $object.id, "/", $edit_version, "/", $edit_language|not|choose( concat( $edit_language, "/" ), '' ) )|ezurl}>
<div class="edit">
	<div class="right-info">

        <input class="button cancel" type="submit" name="DiscardButton" value="{"Cancel"|i18n( 'dms/edit/forum_topic' )}" />
        <input class="button save" type="submit" name="PublishButton" value="{"Submit"|i18n( 'dms/edit/forum_topic' )}" />

	    <input type="hidden" name="DiscardConfirm" value="0" />
        <input type="hidden" name="MainNodeID" value="{$main_node_id}" />
	</div>

    <div class="class-forum-topic" >

        {include uri="design:content/edit_validation.tpl"}

        <h3>{'Subject'|i18n('dms/edit/forum_topic')}</h3>
	<p>
        {attribute_edit_gui attribute=$object.data_map.name}
	</p>
        <h3>{'Message'|i18n('dms/edit/forum_topic')}</h3>
        {attribute_edit_gui attribute=$object.data_map.description id="fmessage"}

    </div>
</div>
</form>
</div>
