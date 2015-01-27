{default attribute_base=ContentObjectAttribute}

{if ne( $attribute_base, 'ContentObjectAttribute' )}
    {def $id_base = concat( 'ezcoa-', $attribute_base, '-', $attribute.contentclassattribute_id, '_', $attribute.contentclass_attribute_identifier )}
{else}
    {def $id_base = concat( 'ezcoa-', $attribute.contentclassattribute_id, '_', $attribute.contentclass_attribute_identifier )}
{/if}
{*}
<label for="{$id_base}_url">{'URL'|i18n( 'design/standard/content/datatype' )}:</label>

<label for="{$id_base}_text">{'Text'|i18n( 'design/standard/content/datatype' )}:</label>
*}

<div class="input-prepend input-group form-group">
    <span class="input-group-addon">{'URL'|i18n( 'design/standard/content/datatype' )}:</span>
    <input id="{$id_base}_url" class="form-control ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" size="70" name="{$attribute_base}_ezurl_url_{$attribute.id}" value="{$attribute.content|wash( xhtml )}" />
</div>
<div class="input-prepend input-group form-group">
    <span class="input-group-addon">{'Text'|i18n( 'design/standard/content/datatype' )}:</span>
    <input id="{$id_base}_text" class="form-control ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" size="70" name="{$attribute_base}_ezurl_text_{$attribute.id}" value="{$attribute.data_text|wash( xhtml )}" />
</div>
{/default}
