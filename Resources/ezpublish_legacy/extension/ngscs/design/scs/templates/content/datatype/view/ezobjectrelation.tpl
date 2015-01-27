
{if $attribute.content}
   {content_view_gui view=text_linked content_object=$attribute.content}
{else}
   {'No relation'|i18n( 'dms/content/relation_list' )}
{/if}