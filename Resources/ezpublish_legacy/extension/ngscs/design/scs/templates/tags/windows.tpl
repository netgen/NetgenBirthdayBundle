{if $tag_exists}
    <div id="node-tab-tags-content-content" class="tab-content{if $tab_index|ne('content')} hide{else} selected{/if}">
        {include uri='design:tags/tabs/latest_content.tpl'}
    <div class="break"></div>
    </div>
{/if}

<div id="node-tab-tags-children-content" class="tab-content{if $tab_index|ne('children')} hide{else} selected{/if}">
    {include uri='design:tags/tabs/eztags_children.tpl' tag_exists=$tag_exists}
    <div class="break"></div>
</div>

{if $tag_exists|not()}
<div id="node-tab-tags-latest-content" class="tab-content{if $tab_index|ne('latest')} hide{else} selected{/if}">
    {include uri='design:tags/tabs/latest_tags.tpl'}
<div class="break"></div>
</div>
{/if}

{if $tag_exists}
    <div id="node-tab-tags-translations-content" class="tab-content{if $tab_index|ne('translations')} hide{else} selected{/if}">
        {include uri='design:tags/tabs/translations.tpl'}
    <div class="break"></div>
    </div>
{/if}

{if and( $tag_exists, $tag.main_tag_id|eq( 0 ) )}
    <div id="node-tab-tags-synonyms-content" class="tab-content{if $tab_index|ne('synonyms')} hide{else} selected{/if}">
        {include uri='design:tags/tabs/synonyms.tpl'}
    <div class="break"></div>
    </div>
{/if}
