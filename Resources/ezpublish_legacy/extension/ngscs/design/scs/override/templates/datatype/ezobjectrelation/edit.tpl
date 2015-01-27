
{default attribute_base=ContentObjectAttribute}
{let class_content=$attribute.contentclass_attribute.content}

{switch match=$class_content.selection_type}

{* Browse. *}
{case match=0}
<div class="block" id="ezobjectrelation_browse_{$attribute.id}">

<table class="list{if $attribute.content|not} hide{/if}" cellspacing="3" cellpadding="3" width="100%">
<thead>
<tr>
    <th>{'Name'|i18n( 'dms/edit/objectrelation' )}</th>
    <th>{'Type'|i18n( 'dms/edit/objectrelation' )}</th>
    <th>{'Section'|i18n( 'dms/edit/objectrelation' )}</th>
    <th>{'Published'|i18n( 'dms/edit/objectrelation' )}</th>
</tr>
</thead>
<tbody>
<tr class="bglight">
{if $attribute.content}

    {* Name *}
    <td>{$attribute.content.name|wash()}</td>

    {* Type *}
    <td>{$attribute.content.class_name|wash()}</td>

    {* Section *}
    <td>{fetch( section, object, hash( section_id, $attribute.content.section_id ) ).name|wash}</td>

    {* Published. *}
    <td>{if $attribute.content.status|ne( 1 )}
            {'No'|i18n( 'dms/edit/objectrelation' )}
        {else}
            {'Yes'|i18n( 'dms/edit/objectrelation' )}
        {/if}
    </td>
{else}
    <td>--name--</td>
    <td>--class-name--</td>
    <td>--section-name--</td>
    <td>--published--</td>
{/if}
</tr>
</tbody>
</table>

<div class="block inline-block">
{if $attribute.class_content.default_selection_node}
    <input type="hidden" name="{$attribute_base}_browse_for_object_start_node[{$attribute.id}]" value="{$attribute.class_content.default_selection_node|wash}" />
{/if}
{if $attribute.content}
    <input class="button ezobject-relation-remove-button" type="submit" name="CustomActionButton[{$attribute.id}_remove_object]" value="{'Remove object'|i18n( 'dms/edit/objectrelation' )}" />
{else}
    <input class="button-disabled ezobject-relation-remove-button" type="submit" name="CustomActionButton[{$attribute.id}_remove_object]" value="{'Remove object'|i18n( 'dms/edit/objectrelation' )}" style="display:none;" disabled="disabled" />
{/if}
</div>
{* <h4>{'Add an object in the relation'|i18n( 'dms/edit/objectrelation' )}</h4> *}
<div style="display:none;">
<input type="hidden" name="{$attribute_base}_data_object_relation_id_{$attribute.id}" value="{$attribute.data_int}" />
{if $attribute.content}
    <input class="button-disabled ezobject-relation-add-button" type="submit" name="CustomActionButton[{$attribute.id}_browse_object]" value="{'Add an existing object'|i18n( 'dms/edit/objectrelation' )}" title="{'Browse to add an existing object in this relation'|i18n( 'dms/edit/objectrelation' )}" disabled="disabled" />
    {include uri='design:content/datatype/edit/ezobjectrelation_ajaxuploader.tpl' enabled=false()}
{else}
    <input class="button ezobject-relation-add-button" type="submit" name="CustomActionButton[{$attribute.id}_browse_object]" value="{'Add an existing object'|i18n( 'dms/edit/objectrelation' )}" title="{'Browse to add an existing object in this relation'|i18n( 'dms/edit/objectrelation' )}" />
    {include uri='design:content/datatype/edit/ezobjectrelation_ajaxuploader.tpl' enabled=true()}
{/if}
</div>
<div class="left linkto-object">
    <input type="text" class="halfbox hide ezobject-relation-search-text" />
    <input type="submit" class="button hide ezobject-relation-search-btn" name="CustomActionButton[{$attribute.id}_browse_object]" value="{'Find object'|i18n( 'dms/edit/objectrelation' )}" />
</div>
<div class="break"></div>
<div class="block inline-block ezobject-relation-search-browse hide"></div>
{include uri='design:content/datatype/edit/ezobjectrelation_ajax_search.tpl'}
</div>
{/case}




{* Dropdown list. *}
{case match=1}
{let parent_node=fetch( content, node, hash( node_id, $class_content.default_selection_node ) )}

<select id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" name="{$attribute_base}_data_object_relation_id_{$attribute.id}">
{if $attribute.contentclass_attribute.is_required|not}
<option value="" {if and(eq( $attribute.data_int, '' ), is_unset($selected_value))}selected="selected"{elseif is_set($disabled)}disabled="disabled"{/if}>{'No relation'|i18n( 'dms/edit/objectrelation' )}</option>
{/if}
{section var=Nodes loop=fetch( content, list, hash( parent_node_id, $parent_node.node_id, sort_by, $parent_node.sort_array ) )}
<option value="{$Nodes.item.contentobject_id}" {if or(eq( $attribute.data_int, $Nodes.item.contentobject_id ), and(is_set($selected_value), $selected_value|wash|eq($Nodes.item.contentobject_id|wash)))}selected="selected"{elseif is_set($disabled)}disabled="disabled"{/if}>{$Nodes.item.name|wash}</option>
{/section}
</select>

{if $class_content.fuzzy_match}
<input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_fuzzy_match" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" name="{$attribute_base}_data_object_relation_fuzzy_match_{$attribute.id}" value="" />
{/if}

{/let}
{/case}


{* Dropdown tree. Not implemented yet, thus unavailable from class edit mode. *}
{case match=2}
{/case}

{case/}

{/switch}

{/let}
{/default}
