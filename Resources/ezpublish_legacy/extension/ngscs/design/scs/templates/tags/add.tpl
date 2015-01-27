{ezcss_require( array( 'jqmodal.css', 'contentstructure-tree.css' ) )}
{ezscript_require( array(   'jquery.eztagschildren.js',
                            'jqmodal.js',
                            'jquery.eztags.js',
                            'tagsstructuremenu.js' ) )}
<div class="col-lg-11 col-sm-10">
    <div class="box">
        <div class="box-header">
            <h2><i class="fa fa-tag"></i>{"New tag"|i18n( 'dms/tags' )}</h2>
            <div class="box-icon">
                <a class="btn-minimize" href="/Users#"><i class="fa fa-chevron-up"></i></a>
            </div>
        </div>

        <div class="box-content">
            {if or($error|count, $warning|count)}
                <div id="messagebox">
                    {if $error|count}
                            <div class="alert alert-warning">
                                <button data-dismiss="alert" class="close" type="button">×</button>
                                <h4 class="alert-heading">Warning!</h4>
                                <p>{$error|wash}</p>
                            </div>
                    {/if}

                    {if $warning|count}
                        <div class="alert alert-warning">
                            <button data-dismiss="alert" class="close" type="button">×</button>
                            <h4 class="alert-heading">Warning!</h4>
                            <p>{$warning|wash}</p>
                        </div>
                    {/if}
                </div>
            {/if}

            {* <p><img src="{$language.locale|flag_icon}" title="{$language.name|wash}" /> {$language.name|wash}</p> *}

            {if ezhttp_hasvariable( 'TagEditParentID', 'post' )}
                {def $parent_tag_id = ezhttp( 'TagEditParentID', 'post' )}
            {else}
                {def $parent_tag_id = $parent_id}
            {/if}

            {def $always_available = ezini( 'GeneralSettings', 'DefaultAlwaysAvailable', 'eztags.ini' )|eq( 'true' )}

            <form name="tageditform" id="tageditform" enctype="multipart/form-data" method="post" action={concat( 'tags/add/', $parent_tag_id )|ezurl}>

                <div class="form-group">
                    <label for="keyword" class="control-label">{'Tag name'|i18n( 'dms/tags' )}</label>
                    <div class="controls row">
                        <div class="input-group col-sm-4">
                            <span class="input-group-addon"><i class="fa fa-tag"></i></span>
                            <input id="keyword" class="form-control" type="text" size="70" name="TagEditKeyword" value="{cond( ezhttp_hasvariable( 'TagEditKeyword', 'post' ), ezhttp( 'TagEditKeyword', 'post' ), '' )|trim|wash}" />
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="controls row">
                        <div class="input-group col-sm-4">
                            <input type="checkbox" name="AlwaysAvailable" {if $always_available}checked="checked"{/if} /> {'Use the main language if there is no prioritized translation.'|i18n( 'dms/tags' )}
                        </div>
                    </div>
                    <input type="hidden" name="Locale" value="{$language.locale|wash}" />
                </div>

                <div class="form-group">
                    <p><strong>{'Parent tag'|i18n( 'dms/tags' )}</strong></p>
                    <input id="eztags_parent_id_0" type="hidden" name="TagEditParentID" value="{$parent_tag_id}" />
                    <input id="hide_tag_id_0" type="hidden" name="TagHideID" value="-1" />
                    <span id="eztags_parent_keyword_0">{eztags_parent_string( $parent_tag_id )|wash}</span>
                    <input class="btn btn-primary" type="button" name="SelectParentButton" id="eztags-parent-selector-button-0" value="{'Select parent'|i18n( 'dms/tags' )}" />
                </div>

                <div class="form-actions hide">
                    <input class="btn btn-success" type="submit" name="SaveButton" value="{'Save'|i18n( 'dms/tags' )}" />
                    <input class="btn" type="submit" name="DiscardButton" value="{'Discard'|i18n( 'dms/tags' )}" onclick="return confirmDiscard( '{'Are you sure you want to discard changes?'|i18n( 'dms/tags' )|wash( javascript )}' );" />
                    <input type="hidden" name="DiscardConfirm" value="1" />
                </div>
            </form>
        </div>
    </div>
</div>

<div class="col-lg-1 col-sm-2">
    <div class="affix-wrapper" data-spy="affix" role="complementary" data-offset-top="70">
        <ul class="actions-nav">
            <li>
                <a onclick="ezpopmenu_submitForm( 'tageditform', null, 'SaveButton' ); return false;" href="#">
                <i  class="fa fa-floppy-o"></i>
                <p>{"Save"|i18n("dms/tags")}</p>
                </a>
            </li>

            <li>
                <a onclick="ezpopmenu_submitForm( 'tageditform', null, 'DiscardButton' ); return false;" href="#">
                <i class="fa fa-times-circle"></i>
                <p>{"Discard"|i18n("dms/tags")}</p>
                </a>
            </li>
        </ul>
    </div>
</div>

{include uri='design:ezjsctemplate/modal_dialog.tpl'}

{literal}
<script language="JavaScript" type="text/javascript">
function confirmDiscard( question )
{
    // Disable/bypass the reload-based (plain HTML) confirmation interface.
    document.tageditform.DiscardConfirm.value = "0";

    // Ask user if she really wants do it, return this to the handler.
    return confirm( question );
}
</script>
{/literal}

{undef $parent_tag_id $always_available}
