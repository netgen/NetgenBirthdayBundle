{*?template charset=UTF-8*}
<fieldset>
    <form action={'translate/search'|ezurl()} method="get">
        <input type="hidden" name="todo" value="search" />

        <div class="col-lg-6">
            <div class="form-group">
                <label class="control-label">{'Search translation key'|i18n('owtranslate')}&nbsp;:&nbsp;</label>
                <input type="text" name="dataKey" value="{cond($dataKeyGet, $dataKeyGet)}" class="form-control" />
            </div>

            <div class="form-group">
                <input type="submit" title="{'Search'|i18n('owtranslate')}" value="{'Search'|i18n('owtranslate')}" class="btn btn-success">
                <a href={'translate/list'|ezurl()} class="btn btn-warning">{'Reset'|i18n('owtranslate')}</a>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="col-lg-6">
                <div class="form-group">
                    <label>{'Choose context'|i18n('owtranslate')}&nbsp;:&nbsp;</label>
                    <select name="sourceKey" class="form-control">
                        <option value="">{'Choose context'|i18n('owtranslate')}</option>
                        {foreach $contextList as $context}
                            <option title="{$context}" value="{$context}" {if eq($sourceKeyGet, $context)}selected{/if}>{$context|shorten(30)}</option>
                        {/foreach}
                    </select>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="form-group">
                    <label>{'Choose language'|i18n('owtranslate')}&nbsp;:&nbsp;</label>
                    <select name="locale" class="form-control">
                        <option value="">{'Choose language'|i18n('owtranslate')}</option>
                        {foreach $languageList as $language}
                            {if $language.locale|eq(ezini( 'MainLocale', 'locale', 'owtranslate.ini' ))}
                                {continue}
                            {/if}
                            <option style="background:url({concat('/share/icons/flags/', $language.locale|extract( 0, 6 ), '.gif')}) no-repeat;padding-left:25px;" title="{$language.name}" value="{$language.locale}" {if eq($localeGet, $language.locale)}selected{/if}>{$language.name}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
        </div>

    </form>
</fieldset>
