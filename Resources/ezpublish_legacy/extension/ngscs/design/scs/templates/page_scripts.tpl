{ezscript_load(array('ezjsc::jquery', 'ezjsc::jqueryio','ezjsc::yui2'))}
<script type="text/javascript" src={"javascript/ezpopupmenu.js"|ezdesign}></script>

{*if and( is_set( $module_result.content_info.persistent_variable.js_files), $module_result.content_info.persistent_variable.js_files)}
    {foreach $module_result.content_info.persistent_variable.js_files as $js_file}AAAA
        {if $js_file|contains('::')}AA{continue}{/if}
        <script type="text/javascript" src={concat('javascript/', $js_file)|ezdesign()} charset="utf-8"></script>
    {/foreach}
{/if*}

{*if and( is_set( $persistent_variable.js_files ), $persistent_variable.js_files )}

    {if $js_file|contains('::')}BB{continue}{/if}
    {foreach $persistent_variable.js_files as $script}
      <script type="text/javascript" src={concat('javascript/', $script)|ezdesign()} charset="utf-8"></script>
    {/foreach}
{/if*}

{* Load scripts for tags *}
{if and( is_set( $persistent_variable.full_view_scripts_top ), $persistent_variable.full_view_scripts_top )}
    {foreach $persistent_variable.full_view_scripts_top as $script}
      <script type="text/javascript" src={concat('javascript/', $script)|ezdesign()} charset="utf-8"></script>
    {/foreach}
{/if}

{if and( is_set( $persistent_variable.full_view_scripts_bottom ), $persistent_variable.full_view_scripts_bottom )}
    {foreach $persistent_variable.full_view_scripts_bottom as $script}
      <script type="text/javascript" src={concat('javascript/', $script)|ezdesign()} charset="utf-8"></script>
    {/foreach}
{/if}
