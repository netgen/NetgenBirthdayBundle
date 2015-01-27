<div class="ie9_hack_dont_remove_this_div"></div>

<form target="transFrame_{$object.content_class.identifier}" enctype="multipart/form-data" method="post" action={concat( "/content/edit/", $object.id, "/", $edit_version, "/", $edit_language|not|choose( concat( $edit_language, "/" ), '' ) )|ezurl}>

	<div class="maincontentheader float-break">
		{if $edit_version|eq(1)}
			<h1>{"New Generic attachment"|i18n( 'dms/file/edit' )}</h1>
		{else}
			<h1>{"Edit %1 - %2"|i18n('dms/file/edit',,array("File"|i18n('dms/file/edit'),$object.name|wash))}</h1>
		{/if}
	</div>
	<div class="right-info">
		<input class="defaultbutton" type="submit" name="PublishButton" value="{"Save"|i18n( 'dms/file/edit' )}" />
		<input class="button" type="submit" name="DiscardButton" value="{"Cancel"|i18n( 'dms/file/edit' )}" />
		<input type="hidden" name="DiscardConfirm" value="0" />
		<input type="hidden" name="MainNodeID" value="{$main_node_id}" />
	</div>

	{include uri="design:content/edit_validation.tpl"}

	<div class="{$object.content_class.identifier}-edit-attributes">
		{include uri="design:content/edit_attribute.tpl"}
	</div>

	<div class="right-info">
		<input class="defaultbutton" type="submit" name="PublishButton" value="{"Save"|i18n( 'dms/file/edit' )}" />
		<input class="button" type="submit" name="DiscardButton" value="{"Cancel"|i18n( 'dms/file/edit' )}" />
		<input type="hidden" name="DiscardConfirm" value="0" />
		<input type="hidden" name="MainNodeID" value="{$main_node_id}" />

		<input type="hidden" name="ngFileUpload" value="1" />
	</div>

</form>
<iframe style="display:none;" name="transFrame_{$object.content_class.identifier}" id="transFrame_{$object.content_class.identifier}"></iframe>
