{ezcss_require( array( 'jqmodal.css', 'contentstructure-tree.css' ) )}
{ezscript_require( array(   'jquery.eztagschildren.js',
                            'jqmodal.js',
                            'jquery.eztags.js',
                            'tagsstructuremenu.js' ) )}

{def $children_object_count = 0}
{def $synonym_object_count = 0}
<div class="col-lg-11 col-sm-10">
    <div class="box">
        <div class="box-header">
            <h2><i class="fa fa-pencil"></i>{"Merge tag"|i18n( 'dms/tags' )}: {$tag.keyword|wash} [{$tag.id}]</h2>
            {* <p><img src="{$language.locale|flag_icon}" title="{$language.name|wash}" /> {$language.name|wash}</p>
            <p>{if $is_main_translation|not}{'Main translation'|i18n( 'dms/tags' )}: {$tag.main_translation.keyword|wash}{/if}</p> *}
            <div class="box-icon">
                <a class="btn-minimize" href="/Users#"><i class="fa fa-chevron-up"></i></a>
            </div>
        </div>

        {if $merge_allowed}
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

                <form name="tageditform" id="tageditform" enctype="multipart/form-data" method="post" action={concat( 'tags/merge/', $tag.id )|ezurl}>

                    <div class="alert alert-info">
                        <button data-dismiss="alert" class="close" type="button">×</button>
                        <strong>Heads up!</strong> {"Merging this tag with another tag will delete the tag and it's synonyms and transfer all related objects to the main tag. Also, all children tags will become main tag children."|i18n( 'dms/tags' )}
                    </div>

                    <p>{"The tag you're about to merge has"|i18n( 'dms/tags' )}:</p>
                    <ul>
                        <li>{'number of first level children tags'|i18n( 'dms/tags' )}: {$tag.children_count}</li>
                        {foreach $tag.children as $child}{set $children_object_count = $children_object_count|sum( $child.related_objects_count )}{/foreach}
                        <li>{'number of objects related to first level children tags'|i18n( 'dms/tags' )}: {$children_object_count}</li>
                        <li>{'number of synonyms'|i18n( 'dms/tags' )}: {$tag.synonyms_count}</li>
                        {foreach $tag.synonyms as $synonym}{set $synonym_object_count = $synonym_object_count|sum( $synonym.related_objects_count )}{/foreach}
                        <li>{'number of objects related to synonyms'|i18n( 'dms/tags' )}: {$synonym_object_count}</li>
                    </ul>

                    <div class="form-group">
                         <div class="controls row">
                            <div class="input-group col-sm-4">
                                {if ezhttp_hasvariable( 'MainTagID', 'post' )}
                                    {def $main_tag_id = ezhttp( 'MainTagID', 'post' )}
                                {else}
                                    {def $main_tag_id = 0}
                                {/if}
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                         <div class="controls row">
                            <div class="input-group col-sm-4">
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
            <div class="form-actions">
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

{if $merge_allowed}
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

{undef}
