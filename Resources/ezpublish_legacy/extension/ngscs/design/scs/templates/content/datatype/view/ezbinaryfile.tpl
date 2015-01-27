{def $icon_size='normal'
     $icon_title=$attribute.content.mime_type}
{if $attribute.has_content}
{if $attribute.content}
    <a href={concat("content/download/",$attribute.contentobject_id,"/",$attribute.id,"/file/",$attribute.content.original_filename)|ezurl}>{$attribute.content.mime_type|mimetype_icon( $icon_size, $icon_title )} {$attribute.content.original_filename|wash( xhtml )}</a> ({$attribute.content.filesize|si( byte )})
{else}
    <div class="message-error"><h2>{'The file could not be found.'|i18n( 'design/ezdemo/view/ezbinaryfile' )}</h2></div>
{/if}
{/if}
