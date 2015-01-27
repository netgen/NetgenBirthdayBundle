
{default attribute_base=ContentObjectAttribute control_matrix=false() control_row=false()}
<input{if $control_matrix} data-control-next="tr" {*onclick="openCloseMatrix(this);"*}{elseif $control_row} data-control-next="td" {*onclick="openCloseNextTd(this);"*}{/if} id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}{if $control_matrix} control-matrix{/if}" type="checkbox" name="{$attribute_base}_data_boolean_{$attribute.id}" {$attribute.data_int|choose( '', 'checked="checked"' )} value="" />
{/default}

