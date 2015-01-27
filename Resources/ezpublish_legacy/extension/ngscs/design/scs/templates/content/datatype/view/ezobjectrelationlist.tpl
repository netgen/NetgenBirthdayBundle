
{if $attribute.content.relation_list}
{def $itemObject = ''}
{foreach $attribute.content.relation_list as $Relations}
{if $Relations.in_trash|not()}
    {set $itemObject = fetch( content, object, hash( object_id, $Relations.contentobject_id ) )}
    {* if dossier contains id and name attribute display custom name*}
    {if $itemObject.data_map.name}
        <a href={$itemObject.main_node.url_alias|ezurl}>{$itemObject.data_map.name.content|wash()}</a>{if is_set($att1)}-{$itemObject.data_map.$att1.content}{/if}{if is_set($att2)}-{$itemObject.data_map.$att2.content}{/if}
    {else}
        {content_view_gui view=embed content_object=$itemObject}{if is_set($att1)}-{$itemObject.data_map.$att1.content}{/if}{if is_set($att2)}-{$itemObject.data_map.$att2.content}{/if}
    {/if}<br />
{/if}
{/foreach}
{else}
{'There are no related objects.'|i18n( 'dms/content/relation_list' )}
{/if}
