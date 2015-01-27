<div class="row">
    <div class="{if or($node.can_create, $node.can_edit)}col-lg-11{else}col-lg-12{/if}">
        <h1>{$node.name|wash()}</h1>
        <div class="box-content">
            {include name=Validation uri='design:content/collectedinfo_validation.tpl'
                 class='alert alert-danger'
                 validation=$validation collection_attributes=$collection_attributes}

            <div class="attribute-short">
                    {attribute_view_gui attribute=$node.data_map.description}
            </div>
            <form method="post" action={"content/action"|ezurl}>

                <div class="form-group">
                    <label class="control-label">{"Your email address"|i18n("design/base")}</label>
                    <div class="controls">
                        {attribute_view_gui attribute=$node.data_map.email}
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label">{"Subject"|i18n("design/base")}</label>
                    <div class="controls">
                        {attribute_view_gui attribute=$node.data_map.subject}
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label">{"Message"|i18n("design/base")}</label>
                    <div class="controls">
                        {attribute_view_gui attribute=$node.data_map.message}
                    </div>
                </div>


                <div class="content-action">
                    <input type="submit" class="btn btn-success" name="ActionCollectInformation" value="{"Send form"|i18n("design/base")}" />
                    <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
                    <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                    <input type="hidden" name="ViewMode" value="full" />
                </div>
            </form>
        </div>
    </div>
    {if $node.can_edit}
    <div class="col-lg-1">
        {if ezini( 'RegionalSettings', 'Locale', 'site.ini' )|ne('eng-GB')}
            <ul class="actions-nav">
            {if $node.can_edit}
                <li>
                    {if $node.object.language_codes|contains(ezini( 'RegionalSettings', 'Locale', 'site.ini' ))|not}
                        <a href="#" onclick="ezpopmenu_submitForm( 'translate' ); return false;">
                            <i class="fa fa-pencil"></i>
                            <p>{"Translate from english"|i18n( 'dms_armenia/agencies/full' )}</p>
                        </a>
                        <form method="post" action={concat("/content/edit/", $node.contentobject_id)|ezurl} id="translate">
                            <input type="hidden" name="EditLanguage" value="{ezini( 'RegionalSettings', 'Locale', 'site.ini' )}" />
                            <input type="hidden" name="FromLanguage" value="eng-GB" />
                            <input type="hidden" name="LanguageSelection" value="Edit" />
                        </form>
                    {else}
                        <a onclick="ezpopmenu_submitForm( 'edit' ); return false;" href="#">
                            <i  class="fa fa-pencil"></i>
                            <p>{"Edit"|i18n("dms/full/agency")}</p>
                        </a>
                        <form method="post" action={"/content/action"|ezurl} id="edit">
                            <input type="hidden" name="NodeID" value="{$node.node_id}" />
                            <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                            <input type="hidden" name="EditButton" value="" />
                            <input type="hidden" name="ContentObjectLanguageCode" value="{$node.object.current_language}" />
                        </form>
                    {/if}
                </li>
            {/if}
            </ul>
        {else}
            <ul class="actions-nav">
                <li>
                    <a onclick="ezpopmenu_submitForm( 'edit' ); return false;" href="#">
                        <i  class="fa fa-pencil"></i>
                        <p>{"Edit"|i18n("dms/full/agency")}</p>
                    </a>
                    <form method="post" action={"/content/action"|ezurl} id="edit">
                        <input type="hidden" name="NodeID" value="{$node.node_id}" />
                        <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                        <input type="hidden" name="EditButton" value="" />
                        <input type="hidden" name="ContentObjectLanguageCode" value="{$node.object.current_language}" />
                    </form>
                </li>
        {/if}
    </div>
    {/if}
</div>
