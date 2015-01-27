<h2>{'My drafts'|i18n( 'dms/dashboard' )}</h2>

{if fetch( 'content', 'draft_count' )}

<table class="list" cellpadding="0" cellspacing="0" border="0" widht="100%">
    <tr>
        <th>{'Name'|i18n( 'dms/dashboard' )}</th>
        <th>{'Type'|i18n( 'dms/dashboard' )}</th>
        <th>{'Modified'|i18n( 'dms/dashboard' )}</th>
        <th class="tight"></th>
    </tr>
    {foreach fetch( 'content', 'draft_version_list', hash( 'limit', $block.number_of_items ) ) as $draft sequence array( 'bglight', 'bgdark' ) as $style}
        <tr class="{$style}">
            <td>
                <a href="{concat( '/content/versionview/', $draft.contentobject.id, '/', $draft.version, '/', $draft.initial_language.locale, '/' )|ezurl('no')}" title="{$draft.name|wash()}">
                    {$draft.name|wash()}
                </a>
            </td>
            <td>
                {$draft.contentobject.class_name|d18n( 'dms/dashboard' )}
            </td>
            <td>
                {$draft.modified|l10n('shortdatetime')}
            </td>
            <td>
                <a class="edit-icon" href="{concat( '/content/edit/', $draft.contentobject.id, '/', $draft.version )|ezurl('no')}" title="{"Edit"|i18n('dms/dashboard')}">{"Edit"|i18n('dms/dashboard')}</a>
            </td>
        </tr>
    {/foreach}
</table>

{else}

{'Currently you do not have any drafts available.'|i18n( 'dms/dashboard' )}

{/if}