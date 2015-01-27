
{let selected_id_array=$attribute.content}
{section var=Options loop=$attribute.class_content.options}
{section-exclude match=$selected_id_array|contains( $Options.item.id )|not}
{$Options.item.name|wash( xhtml )|d18n('dms/content/selection')}{delimiter}<br/>{/delimiter}{/section}
{/let}
