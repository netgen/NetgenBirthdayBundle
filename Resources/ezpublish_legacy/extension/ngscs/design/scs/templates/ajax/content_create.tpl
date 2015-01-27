{* New content creation : START *}
{if $is_logged_in}
<input type="hidden" name="ajaxVariableScope" value="{$class_identifier}">
<input type="hidden" name="ngMceItalicText" value="{"Italic"|i18n("dms/ajax/content_create")}">
{/if}

<div id="{$class_identifier}-view-content" class="ezajax-view-content">

{if $viewContentResult}{$viewContentResult}{/if}
</div>

{if $is_logged_in}

<div id="{$class_identifier}-new-content"></div>
<div id="controls-border"></div>

    <div class="controls ">
    <form id="ajax-actions" class="newElementForm" action={"/content/action"|ezurl} method="post">
        <input class="btn btn-primary NewAjaxContent" type="submit" id="NewButton" name="NewButton" value="{$action_name}" />

        <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
        <input type="hidden" name="ContentObjectID" value="{$node.contentobject_id}" />
        <input type="hidden" name="NodeID" value="{$node.node_id}" />
        <input type="hidden" name="ClassIdentifier" value="{$class_identifier}" />
        <input type="hidden" name="ContentLanguageCode" value="{$object.current_language}" />
        <input type="hidden" name="RedirectURIAfterPublish" value={'ngajaxcrud/status'|ezroot} />
    </form>
    </div>

{/if}
