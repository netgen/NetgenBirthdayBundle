{*?template charset=UTF-8*}
{def $get_parameters_array = array()}
{if $localeGet}
    {set $get_parameters_array = $get_parameters_array|append( concat( 'locale=', $localeGet ) ) }
{/if}
{if $sourceKeyGet}
    {set $get_parameters_array = $get_parameters_array|append( concat( 'sourceKey=', $sourceKeyGet ) ) }
{/if}
{if $dataKeyGet}
    {set $get_parameters_array = $get_parameters_array|append( concat( 'dataKey=', $dataKeyGet ) ) }
{/if}

{def $get_parameters_string = ''}
{if count( $get_parameters_array ) }
    {set $get_parameters_string = concat( '?', $get_parameters_array|implode('&') ) }
{/if}
<table class="table table-striped table-bordered" cellspacing="0">
    <tr class="bgdark">
        <th>{'Translation key'|i18n('owtranslate')}</th>
        <th class="class">{'Context name Translation'|i18n('owtranslate')}</th>
        {if or(lt($languageList|count(), 6), $localeGet)}

            {foreach $dataValues as $localeKey => $values}
                {if $languageList.$localeKey.locale|eq(ezini( 'MainLocale', 'locale', 'owtranslate.ini' ))}
                    {continue}
                {/if}
                <th class="class" style="width: 200px;{if and($localeGet, ne($languageList.$localeKey.locale, $localeGet))}display:none{/if}"><img src="{concat('/share/icons/flags/', $languageList.$localeKey.locale|extract( 0, 6 ), '.gif')}" />&nbsp;{$languageList.$localeKey.name}</th>
            {/foreach}
        {else}
            <th class="class"></th>
        {/if}
    </tr>
{def $compteur = 0}
{foreach $dataList as $sourceKey => $dataSource}
    {foreach $dataSource as $data}
        <tr class="{cond($compteur|mod(2)|eq(0), 'bgdark', 'bglight')}">
            <td><a title="{$data}" href={concat('translate/edit/', '(sourceKey)/', $sourceKey, '/(dataKey)/', $data, $get_parameters_string )|ezurl()}>{$data|shorten(30)}</a></td>
            <td title="{$sourceKey}" class="class"><a href={concat('translate/list/(sourceKey)/', $sourceKey)|ezurl()}>{$sourceKey|shorten(30)}</a></td>
            {if or(lt($languageList|count(), 6), $localeGet)}
                {foreach $dataValues as $localeKey => $values}
                    {if $languageList.$localeKey.locale|eq(ezini( 'MainLocale', 'locale', 'owtranslate.ini' ))}
                        {continue}
                    {/if}
                    <td {if and($localeGet, ne($languageList.$localeKey.locale, $localeGet))}style="display:none"{/if} id="{$localeKey}|{$sourceKey}|{$data}" class="edit {cond($values.$data|eq(''), 'empty_edit')}">{$values.$data}</td>
                {/foreach}
            {else}
                <td class="click-to-open" id="to-{$compteur}">{'Click to open'|i18n('owtranslate')}</td>
            {/if}
        </tr>

        {if and(ge($languageList|count(), 6), $localeGet|not())}
            {include uri='design:translate/translationline.tpl' class=cond($compteur|mod(2)|eq(0), 'bglight', 'bgdark') id=$compteur}
        {/if}

        {set $compteur = $compteur|inc()}
    {/foreach}
{/foreach}
</table>