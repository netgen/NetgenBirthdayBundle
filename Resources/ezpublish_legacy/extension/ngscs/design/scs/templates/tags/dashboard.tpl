{if $show_reindex_message}
    <div id="messagebox">
        <p class="warning">{'Manual search index regeneration is required for changes to be seen in search. Enable DelayedIndexing in site.ini to reindex automatically.'|i18n( 'extension/eztags/warnings' )}</p>
    </div>
{/if}
{include uri='design:tags/window_controls.tpl'}

