{def $is_main_translation = $tag.main_translation.locale|eq( $language.locale )}
<div class="col-lg-11 col-sm-10">
    <div class="box">

        <div class="box-header">
            <h2><i class="fa fa-pencil"></i>{"Edit synonym"|i18n( 'dms/tags' )}: {$tag.keyword|wash} [{$tag.id}]</h2>
            {* <p><img src="{$language.locale|flag_icon}" title="{$language.name|wash}" /> {$language.name|wash}</p>
            <p>{if $is_main_translation|not}{'Main translation'|i18n( 'dms/tags' )}: {$tag.main_translation.keyword|wash}{/if}</p> *}
            {* <p>{if $is_main_translation|not}{'Main translation'|i18n( 'dms/tags' )}: {$tag.main_translation.keyword|wash}{/if}</p> *}
            <div class="box-icon">
                <a class="btn-minimize" href="/Users#"><i class="fa fa-pencil-square-o"></i></a>
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

            <form name="tageditform" id="tageditform" enctype="multipart/form-data" method="post" action={concat( 'tags/editsynonym/', $tag.id )|ezurl}>
                <div class="form-group">
                    <label for="keyword" class="control-label">{'Synonym name'|i18n( 'dms/tags' )}</label>
                     <div class="controls row">
                        <div class="input-group col-sm-4">
                            <span class="input-group-addon"><i class="fa fa-pencil-square-o"></i></span>
                            <input id="keyword" class="form-control" type="text" size="70" name="TagEditKeyword" value="{cond( ezhttp_hasvariable( 'TagEditKeyword', 'post' ), ezhttp( 'TagEditKeyword', 'post' ), $tag.keyword )|trim|wash}" />
                            <input type="hidden" name="Locale" value="{$language.locale|wash}" />
                        </div>
                    </div>
                </div>

                <div class="form-group">
                     <div class="controls row">
                        <div class="input-group col-sm-4">
                            {if $is_main_translation|not}
                                <input type="checkbox" name="SetAsMainTranslation" /> {'Set as main translation'|i18n( 'dms/tags' )}
                            {/if}
                        </div>
                    </div>
                </div>

                <div class="form-group">
                     <div class="controls row">
                        <div class="input-group col-sm-4">
                            {if $is_main_translation|not}
                                <input type="checkbox" name="AlwaysAvailable" {if $tag.always_available}checked="checked"{/if} /> {'Use the main language if there is no prioritized translation.'|i18n( 'dms/tags' )}
                            {/if}
                        </div>
                    </div>
                </div>

                <div class="form-actions hide">
                    <input class="defaultbutton" type="submit" name="SaveButton" value="{'Save'|i18n( 'dms/tags' )}" />
                    <input class="button" type="submit" name="DiscardButton" value="{'Discard'|i18n( 'dms/tags' )}" onclick="return confirmDiscard( '{'Are you sure you want to discard changes?'|i18n( 'dms/tags' )|wash( javascript )}' );" />
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

{undef $is_main_translation}
