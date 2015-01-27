{if fetch( 'user', 'current_user' ).is_logged_in}
<link rel="stylesheet" type="text/css" href={"sq/css/style_editor.css"|ezdesign} />
{else}
<link rel="stylesheet" type="text/css" href={"sq/css/style.css"|ezdesign} />
{/if}
{* needed for ap process step, commented because js weren't loaded properly *}
{*ezcss_load(array('style2.css'))*}

<link rel="stylesheet" type="text/css" href={"stylesheets/style2.css"|ezdesign} />

{if and( is_set( $persistent_variable.full_view_stylesheets ), $persistent_variable.full_view_stylesheets )}
    {foreach $persistent_variable.full_view_stylesheets as $stylesheet}
        <link rel="stylesheet" type="text/css" href={concat('stylesheets/', $stylesheet)|ezdesign()} />
    {/foreach}
{/if}