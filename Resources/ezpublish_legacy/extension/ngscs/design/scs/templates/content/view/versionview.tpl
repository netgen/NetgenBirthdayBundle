{default with_children=true()
         is_editable=true()
	 is_standalone=true()
     content_object=$node.object}


<form method="post" action={concat("content/versionview/",$object.id,"/",$object.current_version,"/",$language)|ezurl} id="preview">

    <input type="hidden" name="ContentObjectID" value="{$object.id}" />
    <input type="hidden" name="ContentObjectVersion" value="{$object.current_version}" />
    <input type="hidden" name="ContentObjectLanguageCode" value="{$object_languagecode}" />
    <input type="hidden" name="ContentObjectPlacementID" value="{$placement}" />

    <div class="hide">
        {if and(eq($version.status,0),$is_creator,$object.can_edit)}
            <input type="submit" name="PreviewPublishButton" value=""/>
            <input type="submit" name="EditButton" value="" />
        {/if}
    </div>

</form>

<div class="row">
    <div class="col-lg-11 col-md-10 col-xs-10">

    {if $assignment}
        {node_view_gui view=full with_children=false() versionview_mode=true() is_editable=false() is_standalone=false() content_object=$object node_name=$object.name content_node=$assignment.temp_node node=$node}
    {else}
        {node_view_gui view=full with_children=false() versionview_mode=true() is_editable=false() is_standalone=false() content_object=$object node_name=$object.name content_node=$node node=$node}
    {/if}
    </div>

    {if and(eq($version.status,0),$is_creator,$object.can_edit)}
    <div class="col-lg-1 col-sm-2">
        <div class="affix-wrapper">
            <ul class="actions-nav">
                <li>
                    <a href="#" onclick="ezpopmenu_submitForm( 'preview', null,'PreviewPublishButton' ); return false;">
                        <i class="fa fa-check"></i>
                        <p>{'Publish'|i18n('design/standard/content/view')}</p>
                    </a>
                </li>
                <li>
                    <a href="#" onclick="ezpopmenu_submitForm( 'preview', null,'EditButton' ); return false;">
                        <i class="fa fa-pencil"></i>
                        <p>{'Edit'|i18n('design/standard/content/view')}</p>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    {/if}
</div>


{/default}