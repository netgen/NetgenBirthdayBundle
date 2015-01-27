{def $has_edit_access = fetch( user, has_access_to, hash( module, tags, function, edit ) )}

<form name="translationsform" method="post" action={'tags/translation'|ezurl}>
    <input type="hidden" name="TagID" value="{$tag.id}" />

    <div class="main-language">
        <input {if $has_edit_access|not}disabled="disabled"{/if} id="tab-translations-alwaysavailable-checkbox" type="checkbox" name="AlwaysAvailable" value="1"{if $tag.always_available} checked="checked"{/if} /> {'Use the main language if there is no prioritized translation.'|i18n( 'dms/tags' )}
        {if $has_edit_access}
            <input id="tab-translations-alwaysavailable-btn" class="btn btn-mini btn-success" type="submit" name="UpdateAlwaysAvailableButton" value="{'Update'|i18n( 'dms/tags' )}" />
            <script type="text/javascript">
            {literal}
            (function( $ ) {
                $('#tab-translations-alwaysavailable-checkbox').change(function() {
                    $('#tab-translations-alwaysavailable-btn').removeClass('button').addClass('defaultbutton');
                });
            })( jQuery );
            {/literal}
            </script>
        {/if}
    </div>
</form>

<table class="table table-striped table-bordered" cellpadding="0">
    <tbody>
        <tr>
            <th>{'Language'|i18n( 'dms/tags' )}</th>
            <th>{'Main'|i18n( 'dms/tags' )}</th>
            <th>{'Translation'|i18n( 'dms/tags' )}</th>
            <th>{'Locale'|i18n( 'dms/tags' )}</th>
            {if $has_edit_access}
                <th class="tight">{'Action'|i18n( 'dms/tags' )}</th>
            {/if}
        </tr>
        {foreach $tag.translations as $translation}
            <tr>
                <td>
                    {*<img src="{$translation.locale|flag_icon}" width="18" height="12" alt="{$translation.locale}" />&nbsp;*}
                    {if $translation.locale|eq( $tag.main_translation.locale )}
                        <strong>{$translation.language_name.name|wash|d18n("dms/tags")}</strong>
                    {else}
                        {$translation.language_name.name|wash|d18n("dms/tags")}
                    {/if}
                </td>
                <td>{if $translation.locale|eq( $tag.main_translation.locale )}<span class="confirm-icon">{'Yes'|i18n( 'dms/tags' )}</span>{/if}</td>
                <td>{$translation.keyword|wash}</td>
                <td>{$translation.locale|wash}</td>
                {if $has_edit_access}
                    <td>
                        <a class="edit-icon" href={concat( '/tags/', cond( $tag.main_tag_id|eq( 0 ), 'edit', 'editsynonym' ), '/', $tag.id, '/', $translation.locale )|ezurl} title="{'Edit'|i18n( 'dms/tags' )}">{'Edit'|i18n( 'dms/tags' )}</a>
                        {if $translation.locale|ne( $tag.main_translation.locale )}
                        <form name="translationsform" method="post" action={'tags/translation'|ezurl}>
                            <input type="hidden" name="TagID" value="{$tag.id}" />
                            <input type="hidden" name="Locale[]" value="{$translation.locale|wash}" />
                            <input type="hidden" name="MainLocale" value="{$translation.locale|wash}" />
                            <input class="delete-icon" type="submit" name="RemoveTranslationButton" value="{'Delete'|i18n( 'dms/tags' )}" title="{'Delete'|i18n( 'dms/tags' )}" />
                            <input class="btn btn-mini btn-primary" type="submit" name="UpdateMainTranslationButton" value="{'Set main'|i18n( 'dms/tags' )}" title="{'Set main'|i18n( 'dms/tags' )}" />
                        </form>
                        {/if}
                    </td>
                {/if}
            </tr>
        {/foreach}
    </tbody>
</table>


