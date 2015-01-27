<div class="content-view-line testclass_mario" id="obid-{$node.object.id}">
	<div class="attribute-header">
		<h2><a href={$node.url_alias|ezurl} title="{$node.name|wash}">{$node.name|wash}</a><h2>
	</div>

	{if $is_logged_in}
		<div class="line-buttons">
			<form id="form-actions" action={"/content/action"|ezurl} method="post">
				<input class="button" type="submit" id="EditButton" name="EditButton" value="{'Edit'|i18n( 'dms/ajax' )}" onclick="return editContent(this,'obid-{$node.object.id}')" />
				<input class="button" type="submit" id="DeleteButton" name="ActionRemove" value="{'Delete'|i18n( 'dms/ajax' )}" onclick="return deleteContent(this,'obid-{$node.object.id}')"/>
				
				<input type="hidden" name="ContentObjectID" value="{$node.object.id}">
				<input type="hidden" name="ContentNodeID" value="{$node.node_id}">

				<input type="hidden" name="ContentObjectLanguageCode" value="{ezini( 'RegionalSettings', 'ContentObjectLocale', 'site.ini' )}">
				
				<input type="hidden" name="RedirectURIAfterRemove" value="{'ngajaxcrud/status'|ezurl}">
				<input type="hidden" name="RedirectIfCancel" value="{'ngajaxcrud/status'|ezurl}">
				<input type="hidden" name="CancelURI" value="{'ngajaxcrud/status'|ezurl}">
				
				
			</form>
		</div>
	{/if}
</div>