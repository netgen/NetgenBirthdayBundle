<div class="col-lg-11 col-sm-10">

    <h1>{"New tag"|i18n( 'dms/tags' )}</h1>

    {if ezhttp_hasvariable( 'TagEditParentID', 'post' )}
        {def $parent_tag_id = ezhttp( 'TagEditParentID', 'post' )}
    {else}
        {def $parent_tag_id = $parent_id}
    {/if}

    <form method="post" action={concat( 'tags/add/', $parent_tag_id )|ezurl}>
        <div class="row">
            <div class="box">
                <div class="box-header" data-original-title>
                    <h2><i class="fa fa-flag"></i>{'Add translation'|i18n('dms/tags')}</h2>
                    <div class="box-icon">
                        <a class="btn-minimize" href="#"><i class="fa fa-chevron-up"></i></a>
                    </div>
                </div>

                <div class="box-content">
                    <div class="clearfix">
                        <p>{'Select the translation you want to add'|i18n('dms/tags')}:</p>
                    </div>

                    {foreach $languages as $index => $language}
                        <div class="clearfix">
                            <input name="Locale" type="radio" value="{$language.locale|wash}" {if $index|eq(0)}checked="checked"{/if} > {$language.name|wash|d18n("dms/tags")}
                        </div>
                    {/foreach}
                </div>
            </div>
        </div>
        <div class="row">
            <input class="btn btn-primary" type="submit" name="AddTranslationButton" value="{'New tag'|i18n( 'dms/tags' )}" />
            <input class="btn" type="submit" name="DiscardButton" value="{'Discard'|i18n( 'dms/tags' )}" />
        </div>
    </form>
</div>

{undef $parent_tag_id}
