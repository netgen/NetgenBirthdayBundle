{if $attribute.content.is_valid}{makedate( $attribute.content.month, $attribute.content.day, 1990)|datetime( 'custom', '%d %F' )} {$attribute.content.year}{/if}
