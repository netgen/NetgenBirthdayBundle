{ezcss_require( array( 'tagssuggest.css', 'jqmodal.css', 'contentstructure-tree.css' ) )}
{ezscript_require( array( 'jqmodal.js', 'jquery.tagsSuggest.js', 'tagsSuggest-init.js', 'tag_select.js' ) )}

{def $has_add_access = false()}
{def $tag_tree = $attribute.contentclass_attribute.data_int1}
{def $root_tag = fetch( tags, tag, hash( tag_id, $tag_tree ) )}

{def $user_limitations = user_limitations( 'tags', 'add' )}
{if $user_limitations['accessWord']|ne( 'no' )}
    {if is_unset( $user_limitations['simplifiedLimitations']['Tag'] )}
        {set $has_add_access = true()}
    {elseif $root_tag}
        {foreach $user_limitations['simplifiedLimitations']['Tag'] as $key => $value}
            {if $root_tag.path_string|contains( concat( '/', $value, '/' ) )}
                {set $has_add_access = true()}
                {break}
            {/if}
        {/foreach}
    {else}
        {set $has_add_access = true()}
        {set $root_tag = array()}
        {foreach $user_limitations['simplifiedLimitations']['Tag'] as $key => $value}
            {set $root_tag = $root_tag|append( fetch( tags, tag, hash( tag_id, $value ) ) )}
        {/foreach}
    {/if}
{/if}

{default attribute_base=ContentObjectAttribute}
<div class="tagssuggest{if $attribute.contentclass_attribute.data_int2} tagsfilter{/if}">
    <div style="display:none">
    <label>{'Selected tags'|i18n( 'dms/edit/tags' )}:</label>
    <div class="tags-list tags-listed no-results">
        <p class="loading">{'Loading'|i18n( 'dms/edit/tags' )}...</p>
        <p class="no-results">{'There are no selected tags'|i18n( 'dms/edit/tags' )}.</p>
    </div>

    <label>{'Suggested tags'|i18n( 'dms/edit/tags' )}:</label>
    <div class="tags-list tags-suggested no-results">
        <p class="loading">{'Loading'|i18n( 'dms/edit/tags' )}...</p>
        <p class="no-results">{'There are no tags to suggest'|i18n( 'dms/edit/tags' )}.</p>
    </div>

    <div class="tagssuggestfieldwrap">
        <input class="tagssuggestfield" type="text" size="70" name="suggest_{$attribute_base}_eztags_data_text_{$attribute.id}" value="" autocomplete="off" />
    </div>

    </div>

    {def $display_tags_array = ezini('TagSettings', 'DisplayTags', 'dms.ini')}
    {def $multivalue_max_select_array = ezini('TagSettings', 'MultivalueMaxSelect', 'dms.ini')}
    {def $display_type = $display_tags_array[$attribute.contentclass_attribute_identifier]}

    {def $fetch_type = 'list'}

    {if eq($display_type,'single')}
        {set $fetch_type = 'tree'}
    {/if}

    {def $tag_list = fetch(tags, $fetch_type, hash('parent_tag_id', $tag_tree, 'sort_by', array( array('path_string', true) ) ))}

    {def $display_tags_array = ezini('TagSettings', 'DisplayTags', 'dms.ini')}
    <script type="text/javascript">
        $(document).ready(function(){ldelim}
             new tagSelect({ldelim}
                'attributeID':"{$attribute.id}",
                'attributeBase':"{$attribute_base}",
                'attributeLanguageCode':"{$attribute.language_code}",
                'displayType':"{$display_type}",
                'maxSelect':"{if $multivalue_max_select_array}{$multivalue_max_select_array[$attribute.contentclass_attribute_identifier]}{/if}"
            {rdelim});
        {rdelim});

    </script>

	<select name="tag_select_{$attribute.id}" data-parentid="{$attribute.contentclass_attribute.data_int1}" class="tag_select" style="width:160px;">
            <option value=""></option>
        {foreach $tag_list as $fetched_tag}
            <option value="{$fetched_tag.id}" {if is_set($selected_values)}{foreach $selected_values as $value}{if eq($value, $fetched_tag.keyword)}selected{/if}{/foreach}{/if}>{if $fetched_tag.depth|gt(2)}&nbsp;&nbsp;&nbsp;&nbsp;{/if}{$fetched_tag.keyword}</option>
        {/foreach}
    </select>

    <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="box ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier} tagnames" type="hidden" name="{$attribute_base}_eztags_data_text_{$attribute.id}" value="{$attribute.content.keyword_string|wash}"  />

    <input id="ezcoa2-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="box tagpids" type="hidden" name="{$attribute_base}_eztags_data_text2_{$attribute.id}" value="{$attribute.content.parent_string|wash}"  />

    <input id="ezcoa3-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="box tagids" type="hidden" name="{$attribute_base}_eztags_data_text3_{$attribute.id}" value="{$attribute.content.id_string|wash}"  />

    <input id="ezcoa4-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="box taglocales" type="hidden" name="{$attribute_base}_eztags_data_text4_{$attribute.id}" value="{$attribute.content.locale_string|wash}" />

    <input type="hidden" class="eztags_subtree_limit" name="eztags_subtree_limit-{$attribute.id}" value="{$attribute.contentclass_attribute.data_int1}" />
    <input type="hidden" class="eztags_hide_root_tag" name="eztags_hide_root_tag-{$attribute.id}" value="{$attribute.contentclass_attribute.data_int3}" />
    <input type="hidden" class="eztags_max_tags" name="eztags_max_tags-{$attribute.id}" value="{if $attribute.contentclass_attribute.data_int4|gt( 0 )}{$attribute.contentclass_attribute.data_int4}{else}0{/if}" />

</div>

{*if $has_add_access}
    {include uri='design:ezjsctemplate/modal_dialog.tpl' attribute_id=$attribute.id root_tag=$root_tag}
{/if*}
{/default}
