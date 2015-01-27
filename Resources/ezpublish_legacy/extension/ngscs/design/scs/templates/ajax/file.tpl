<div class="line-wrapper">
	<div class="content-view-line {$node.content_class.identifier}" id="obid-{$node.object.id}" data-id="{$node.object.id}">
		{if $is_logged_in}
			<div class="line-buttons">
				<form id="form-actions" action={"/content/action"|ezurl} method="post">
					<input class="button" type="submit" id="EditButton" name="EditButton" value="{"Edit"|i18n('dms/line/file')}" />
					<input class="button" type="submit" id="DeleteButton" name="ActionRemove" value="{"Remove"|i18n('dms/line/file')}" />
					<input type="hidden" name="ContentObjectID" value="{$node.object.id}">
					<input type="hidden" name="ContentNodeID" value="{$node.node_id}">

					<input type="hidden" name="ContentObjectLanguageCode" value="{$node.object.current_language}">
					
					<input type="hidden" name="RedirectURIAfterRemove" value="{'ngajaxcrud/status'|ezroot}">
					<input type="hidden" name="RedirectIfCancel" value="{'ngajaxcrud/status'|ezroot}">
					<input type="hidden" name="CancelURI" value="{'ngajaxcrud/status'|ezroot}">
				</form>
			</div>
		{/if}
		<div class="attribute-byline">
			<p class="date">{$node.object.owner.name|wash}, {$node.object.published|l10n(date)}</p>
		</div>
		
		{if $node.object.data_map.metadata.has_content}
		<div class="meta_attach">
			<span>{"Metadata"|i18n('dms/line/file')}: <strong>{attribute_view_gui attribute=$node.object.data_map.metadata}</strong></span>
		</div>
		{/if}

		<h2>{*$node.object.data_map.file.content.mime_type|mimetype_icon( 'small', '' )*} {"File"|i18n('dms/line/file')}: {attribute_view_gui attribute=$node.object.data_map.file icon_size='small' icon_title=$node.name} {if $no_edit}<span style="font-weight:normal;font-size:11px">[ {"with dossier"|i18n( 'dms/line/file' )}: <a href={$node.parent.url_alias|ezurl}>{$node.parent.data_map.id.content}</a> ]</span>{/if}</h2>

		<div class="attribute-short">
		{attribute_view_gui attribute=$node.object.data_map.description}
		</div>
		
	</div>	
</div>
