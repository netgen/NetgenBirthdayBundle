{ezcss_require( array( 'contentstructure-tree.css', 'jqmodal.css', 'tagssuggest.css' ) )}
{ezscript_require( array( 'jqmodal.js', 'jquery.eztags.js', 'tagsstructuremenu.js', 'matrixhandler.js' ) )}

<form enctype="multipart/form-data" id="edit-content" method="post" action={concat("/content/edit/",$object.id,"/",$edit_version,"/",$edit_language|not|choose(concat($edit_language,"/"),''))|ezurl}>
<div class="form-actions hide">
    <input type="submit" name="PublishButton"  />
    <input type="submit" name="StoreButton"  />
    <input  type="submit" name="DiscardButton"  />
    <input type="submit" name="VersionsButton"/>
</div>

<div class="row">
    <div class="col-lg-2 col-sm-3">

        <div class="box">
            <div class="box-header" data-original-title>
                <h2>{"Object info"|i18n("design/standard/content/edit")}</h2>
            </div>
            <div class="box-content">
                <label>{"Created"|i18n("design/standard/content/edit")}</label>
                {if $object.published}
                    <p>{$object.published|l10n(date)}</p>
                {else}
                    <p>{"Not yet published"|i18n("design/standard/content/edit")}</p>
                {/if}
                <label>{"Last Modified"|i18n("design/standard/content/edit")}</label>
                {if $object.modified}
                    <p>{$object.modified|l10n(date)}</p>
                {else}
                    <p>{"Not yet published"|i18n("design/standard/content/edit")}</p>
                {/if}
            </div>
        </div>

        <div class="box">
            <div class="box-header" data-original-title>
                <h2>{"Versions"|i18n("design/standard/content/edit")}</h2>
            </div>
            <div class="box-content">
                <label>{"Editing"|i18n("design/standard/content/edit")}</label>
                <p>{$edit_version}</p>
                <label>{"Current"|i18n("design/standard/content/edit")}</label>
                <p>{$object.current_version}</p>
            </div>
        </div>

    </div>

    <div class="col-lg-9 col-sm-7">
        <div class="box">
            <div class="box-header" data-original-title>
                <h2>{"Edit %1 - %2"|i18n("design/standard/content/edit",,array($class.name|wash,$object.name|wash))}</h2>
                <div class="box-icon">
                    <a href="#" class="btn-minimize"><i class="fa fa-chevron-up"></i></a>
                </div>
            </div>
            <div class="box-content">

                {include uri="design:content/edit_validation.tpl"}

                {include uri="design:content/edit_attribute.tpl"}
            </div>

        </div>
    </div>

    <div class="col-lg-1 col-sm-2">
        <ul class="actions-nav">
            <li>
                <a href="#" onclick="ezpopmenu_submitForm( 'edit-content', null, 'PublishButton' ); return false;">
                    <i class="fa fa-check"></i>
                    <p>{"Save"|i18n( 'design/standard/content/edit' )}</p>
                </a>
            </li>
            <li>
                <a href="#" onclick="ezpopmenu_submitForm( 'edit-content', null, 'StoreButton' ); return false;">
                    <i class="fa fa-save"></i>
                    <p>{"Store draft"|i18n( 'design/standard/content/edit' )}</p>
                </a>
            </li>
            <li>
                <a href="#" onclick="ezpopmenu_submitForm( 'edit-content', null, 'VersionsButton' ); return false;">
                    <i class="fa fa-list-alt"></i>
                    <p>{'Manage versions'|i18n('design/standard/content/edit')}</p>
                </a>
            </li>
            <li>
                <a href="#" onclick="ezpopmenu_submitForm( 'edit-content', null, 'DiscardButton' ); return false;">
                    <i class="fa fa-times"></i>
                    <p>{"Discard"|i18n( 'design/standard/content/edit' )}</p>
                </a>
            </li>
        </ul>
    </div>
</div>

</form>
