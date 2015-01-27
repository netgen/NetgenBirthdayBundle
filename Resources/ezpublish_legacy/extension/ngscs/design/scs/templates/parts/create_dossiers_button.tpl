<div class="right-info highlight">

{def $link_title = 'Undefined dossier type'|i18n( 'dms/dossier/search' )}

{if and(is_set($type), ezini_hasvariable( 'DMSSettings', concat($type|upcase(), 'Text'), 'dms.ini' ))}
    {set $link_title = concat("Create"|i18n( 'dms/dossier/search' )," ",ezini('DMSSettings', concat($type|upcase(), 'Text'), 'dms.ini')|d18n( 'dms/dossier/search' ))}
{/if}

	<a href="#" title="{$link_title}" data-dropdownbutton="">{$link_title}</a>

	<form action={"/content/action"|ezurl} method="post" id="create-dossier" style="display: none">
		{if $default_parents|count|eq(1)}
			<input type="hidden" name="NodeID" value="{$default_parents[0].node_id}" />
		{elseif $default_parents|count|not()}
			<input type="hidden" name="NodeID" value="{$node.node_id}" />
		{else}
			<label for="NodeID">{"Choose issuing agency"|i18n( 'dms/dossier/search' )}</label>
			<select name="NodeID" data-triggersubmit="create-dossier">
			<option value=""></option>
			{foreach $default_parents as $g}<option value="{$g.node_id}">{$g.name}</option>{/foreach}</select>
		{/if}
		<input type="hidden" name="ClassID" value="{$create_cid}" />
		<input type="hidden" name="NewButton" value="" />
		<input type="hidden" name="ContentLanguageCode" value="{ezini( 'RegionalSettings', 'ContentObjectLocale', 'site.ini' )}" />
	</form>
</div>

{*
<div class="right-info highlight">
	<form action={"/content/action"|ezurl} method="post" id="create-dossier">
		{if $default_parents|count|eq(1)}
			<input type="hidden" name="NodeID" value="{$default_parent}" />
		{elseif $default_parents|count|not()}
			<input type="hidden" name="NodeID" value="{$node.node_id}" />
		{else}
			<select name="NodeID" style="width:80px">{foreach $default_parents as $g}<option value="{$g.node_id}">{$g.name}</option>{/foreach}</select>
		{/if}
		<input type="hidden" name="ClassID" value="{$create_cid}" />
		<input type="hidden" name="NewButton" value="" />
		<input type="hidden" name="ContentLanguageCode" value="{ezini( 'RegionalSettings', 'ContentObjectLocale', 'site.ini' )}" />
	</form>
	<ul class="links">
		<li><a href="#" onclick="ezpopmenu_submitForm( 'create-dossier' ); return false;">{concat("Create"|i18n( 'dms/dossier/search' )," ",ezini('DMSSettings', concat($type|upcase(), 'Text'), 'dms.ini')|d18n( 'dms/dossier/search' ))}</a></li>
	</ul>
</div>
*}
