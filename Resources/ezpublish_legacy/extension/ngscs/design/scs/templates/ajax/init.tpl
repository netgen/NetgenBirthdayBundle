{ezscript_require( array( 'rgmajax.js' ) )}
{*set scope=global persistent_variable=hash('full_view_scripts_bottom', array('rgmajax.js'))*}
{if is_set( $classIdentifier )|not}
  Please provide classIdentifier param when you include "ajax/init.tpl"
{else}
    {default actionName = 'Not valid action name'}
    {default showBottomControls = false()}

    {if $showBottomControls}{set $showBottomControls = 1}{else}{set $showBottomControls = 0}{/if}

    {def $current_user = fetch( 'user', 'current_user' )}
    {ezpagedata_set( 'load_tiny_mce', $current_user.is_logged_in )}
    {ezpagedata_set('load_tags_script', $current_user.is_logged_in )}


    <div id="{$classIdentifier}-ezajaxcontent" class="ezajaxcontent">
      <img class="ajax-loader" src={'ajax-loader.gif'|ezimage} alt="Loading..." />
    </div>

    <script type="text/javascript">
    {literal}
      new rgmAjax({
        enableMyDebug : true,

        ObjectID: {/literal}{$node.contentobject_id}{literal},
        ActionName: '{/literal}{$actionName}{literal}',
        MainNodeId: '{/literal}{$node.node_id}{literal}',
        ShowBottomControls: '{/literal}{$showBottomControls}{literal}'{/literal}{* SortBy HACK:START trenutno neznam bolje rjesenje za ubacivanje sortby attributa *}{if $classIdentifier|eq('article_ld')},SortByAttribute: '{$classIdentifier}'{/if}{* SortBy HACK:END *}{literal},

        classIdentifier : '{/literal}{$classIdentifier}{literal}',
        {/literal}{if is_set( $layout )}layout: '{$layout}',{/if}{literal}
        ajaxTextHTML : '<img class="ajax-loader" src={/literal}{'ajax-loader.gif'|ezimage}{literal} alt="Loading..." />'
      });

    {/literal}
    </script>
{/if}
