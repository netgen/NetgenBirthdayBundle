{if $edit_version|eq(1)}
<h1>{"New"|i18n( 'dms/edit/user' )} {"User group"|i18n( 'dms/edit/user' )}</h1>
{else}
<h1>{"Edit"|i18n( 'dms/edit/user' )} {"User group"|i18n( 'dms/edit/user' )}</h1>
{/if}

<form enctype="multipart/form-data" method="post" action={concat("/content/edit/",$object.id,"/",$edit_version,"/",$edit_language|not|choose(concat($edit_language,"/"),''))|ezurl}>

	<div class="right-info">
    <input class="button save" type="submit" name="PublishButton" value="{"Save"|i18n( 'dms/edit/user' )}" />
    <input class="button cancel" type="submit" name="DiscardButton" value="{"Cancel"|i18n( 'dms/edit/user' )}" />
    <input type="hidden" name="DiscardConfirm" value="0" />
    {*<input type="hidden" name="RedirectURIAfterPublish" value="/" />
    <input type="hidden" name="RedirectIfDiscarded" value="/" />*}
    </div>

<div class="break"></div>

{include uri="design:content/edit_validation.tpl"}

<div class="editform-user">
	<table border="0" cellpadding="3" cellspacing="3" width="100%" class="list">
	<tr>
		<td width="20%">{"Name"|i18n( 'dms/edit/user' )}: </td><td><b>{attribute_edit_gui attribute=$object.data_map.name}</b></td>
	</tr>
	
	<tr>
		<td width="20%">{"Description"|i18n( 'dms/edit/user' )}: </td><td><b>{attribute_edit_gui attribute=$object.data_map.description}</b></td>
	</tr>

	</table>
</div>
    {*include uri="design:content/edit_attribute.tpl"*}

</form>