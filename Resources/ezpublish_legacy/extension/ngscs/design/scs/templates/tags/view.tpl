<div class="col-lg-11 col-sm-10">
    <h1>{$tag.keyword|wash()}</h1>
    {*<div class="box">
        <div class="box-header">
            <h2>
                <i class="fa fa-tag"></i>
                <span class="break"></span>
                {if $tag.main_tag_id|eq( 0 )}
                    {'Tag'|i18n( 'dms/tags' )}: {$tag.keyword|wash}
                {else}
                    {'Synonym'|i18n( 'dms/tags' )}: {$tag.keyword|wash}
                {/if}
            </h2>
            <div class="box-icon">
                <a href={$tag.depth|gt(1)|choose( '/tags/dashboard'|ezurl, concat( '/tags/id/', $tag.parent.id )|ezurl )} title="{'Up one level.'|i18n(  'dms/tags'  )}"><i class="fa fa-level-up"></i></a>
                <a class="btn-minimize" href="/Users#"><i class="fa fa-chevron-up"></i></a>
            </div>
        </div>

        <div class="box-content">
            <div class="header-mainline">
                {if $tag.main_tag_id|ne( 0 )}
                    <p>{'Main tag'|i18n( 'dms/tags' )}: <a href={concat( 'tags/id/', $tag.main_tag_id )|ezurl}>{$tag.main_tag.keyword|wash}</a></p>
                {/if}
            </div>
            {if $show_reindex_message}
                <div id="messagebox">
                    <p class="warning">{'Manual search index regeneration is required for changes to be seen in search. Enable DelayedIndexing in site.ini to reindex automatically.'|i18n( 'extension/eztags/warnings' )}</p>
                </div>
            {/if}
            <p class="left modified">{'Last modified'|i18n( 'dms/tags' )}: {$tag.modified|l10n(shortdatetime)} ({'Tag ID'|i18n( 'dms/tags' )}: {$tag.id})</p>
            <p class="right translation">{'Language'|i18n( 'dms/tags' )}: {$tag.language_name_array[$tag.current_language]|wash|d18n('dms/tags')}&nbsp;{*<img src="{$tag.current_language|flag_icon}" width="18" height="12" alt="{$tag.current_language|wash}" style="vertical-align: middle;" /></p>

        </div>
    </div>*}

    <div class="box-content">
        <div id="window-controls">
            {include uri='design:tags/window_controls.tpl'}
        </div>
    </div>
</div>

<div class="col-lg-1 col-sm-2">
    {if $tag.main_tag_id|eq( 0 )}
        {include uri='design:tags/parts/tags_view_control_bar.tpl' tag=$tag}
    {else}
        {include uri='design:tags/parts/synonyms_view_control_bar.tpl' tag=$tag}
    {/if}
</div>
