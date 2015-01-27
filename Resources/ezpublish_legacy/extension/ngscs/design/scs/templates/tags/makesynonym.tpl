{ezcss_require( array( 'jqmodal.css', 'contentstructure-tree.css' ) )}
{ezscript_require( array(   'jquery.eztagschildren.js',
                            'jqmodal.js',
                            'jquery.eztags.js',
                            'tagsstructuremenu.js' ) )}
<div class="col-lg-11 col-sm-10">
    <div class="box">
        <div class="box-header">
            <h2><i class="fa fa-pencil"></i>{"Convert to synonym"|i18n( 'dms/tags' )}: {$tag.keyword|wash} [{$tag.id}]</h2>
            {* <p><img src="{$language.locale|flag_icon}" title="{$language.name|wash}" /> {$language.name|wash}</p>
            <p>{if $is_main_translation|not}{'Main translation'|i18n( 'dms/tags' )}: {$tag.main_translation.keyword|wash}{/if}</p> *}
            <div class="box-icon">
                <a class="btn-minimize" href="/Users#"><i class="fa fa-chevron-up"></i></a>
            </div>
        </div>

        {if $convert_allowed}
            <div class="box-content">
                <form name="tageditform" id="tageditform" enctype="multipart/form-data" method="post" action={concat( 'tags/makesynonym/', $tag.id )|ezurl}>

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

                    <div class="form-group">
                         <div class="controls row">
                            <div class="input-group col-sm-4">
                                {if ezhttp_hasvariable( 'MainTagID', 'post' )}
                                    {def $main_tag_id = ezhttp( 'MainTagID', 'post' )}
                                {else}
                                    {def $main_tag_id = 0}
                                {/if}

                                <p><strong>{'Main tag'|i18n( 'dms/tags' )}</strong></p>
                                <input id="eztags_parent_id_0" type="hidden" name="MainTagID" value="{$main_tag_id}" />
                                <input id="hide_tag_id_0" type="hidden" name="TagHideID" value="{$tag.id}" />
                                <span id="eztags_parent_keyword_0">{eztags_parent_string( $main_tag_id )|wash}</span>
                                <input class="btn btn-primary" type="button" name="SelectParentButton" id="eztags-parent-selector-button-0" value="{'Select main tag'|i18n( 'dms/tags' )}" />
                            </div>
                        </div>
                    </div>

                    <div class="form-actions hide">
                        <input class="btn btn-success" type="submit" name="SaveButton" value="{'Save'|i18n( 'dms/tags' )}" />
                        <input class="btn" type="submit" name="DiscardButton" value="{'Discard'|i18n( 'dms/tags' )}" onclick="return confirmDiscard( '{'Are you sure you want to discard changes?'|i18n( 'dms/tags' )|wash( javascript )}' );" />
                        <input type="hidden" name="DiscardConfirm" value="1" />
                    </div>
                </form>
            </div>
        {else}
             <div class="form-actions hide">
                <input class="btn" type="button" onclick="javascript:history.back();" value="{'Go back'|i18n( 'dms/tags' )}" />
            </div>
        {/if}
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

{if $convert_allowed}
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
{/if}
