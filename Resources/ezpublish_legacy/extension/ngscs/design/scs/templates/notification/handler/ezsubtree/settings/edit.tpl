{let subscribed_nodes=$handler.rules}
<div class="box">
    <div class="box-header" data-original-title>
        <h2><i class="fa fa-th"></i><span class="break"></span>{"List of notifications"|i18n( 'dms/notification/edit' )}</h2>
    </div>

    <div class="box-content">

		<table class="table table-striped table-bordered">
		<tr>
			<th width="1%">
			{"Select"|i18n("dms/notification/edit")}
			</th>
			<th width="99%">
			{"Name"|i18n( 'dms/notification/edit' )}
			</th>
			{*
			<th width="30%">
			{"Type"|i18n( 'dms/notification/edit' )}
			</th>
			*}
		</tr>

		{section name=Rules loop=$subscribed_nodes sequence=array(bgdark,bglight)}
		<tr>
			<td class="{$Rules:sequence}">
			      <input type="checkbox" name="SelectedRuleIDArray_{$handler.id_string}[]" value="{$Rules:item.id}" />
			</td>

		    <td class="{$Rules:sequence}">
			<a href={concat("/content/view/full/",$Rules:item.node.node_id,"/")|ezurl}>
			{$Rules:item.node.name|wash}
		        </a>
			</td>
			{*
			<td class="{$Rules:sequence}">
			{$Rules:item.node.object.content_class.name|wash|d18n('dms/notification/edit')}
			</td>
			*}
		</tr>
		{/section}
		</table>
		{*<input class="button" type="submit" name="NewRule_{$handler.id_string}" value="{'New'|i18n('dms/notification/edit')}" />*}
		<input class="btn btn-danger" type="submit" name="RemoveRule_{$handler.id_string}" value="{"Remove selected"|i18n('dms/notification/edit')}" />
	</div>
</div>
{/let}
