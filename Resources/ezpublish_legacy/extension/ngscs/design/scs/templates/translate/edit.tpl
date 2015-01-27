{*?template charset=UTF-8*}
{if is_set($dataforEdit)}
{def
$localeGet = false()
$sourceKeyGet = false()
$dataKeyGet = false()
}
{if ezhttp_hasvariable( 'locale', 'get' )}
    {set $localeGet = ezhttp( 'locale', 'get' )}
{/if}
{if ezhttp_hasvariable( 'sourceKey', 'get' )}
    {set $sourceKeyGet = ezhttp( 'sourceKey', 'get' )}
{/if}
{if ezhttp_hasvariable( 'dataKey', 'get' )}
    {set $dataKeyGet = ezhttp( 'dataKey', 'get' )}
{/if}
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
<h1>{'Edit translation'|i18n('owtranslate')} {$dataKey}</h1>

<div class="row">
    <div class="col-lg-11 col-sm-10">
        <form action={'translate/edit'|ezurl()} method="post" id="translation-form">

            <input type="hidden" name="RedirectionURIString" value="{$get_parameters_string}">

    {*
            <div class="box-header">
                <div class="button-left">
                    <h2><i class="fa fa-file-text"></i>>&nbsp;{'Edit translation'|i18n('owtranslate')} &lt;{$dataKey}&gt;</h2>
                </div>
            </div>*}

            <div class="box-content">
                <input type="hidden" name="todo" value="validEdit" />
                <input type="hidden" name="dataKey" value="{$dataKey}" />
                <input type="hidden" name="sourceKey" value="{$sourceKey}" />

                {foreach $dataforEdit as $keyLanguage => $value}
                {if $languageList[$keyLanguage].locale|eq(ezini( 'MainLocale', 'locale', 'owtranslate.ini' ))}
                    {continue}
                {/if}
                    <div class="form-group">
                        <label><img src="{concat('/share/icons/flags/', $languageList.$keyLanguage.locale|extract( 0, 6 ), '.gif')}" />&nbsp;{$languageList.$keyLanguage.name}</label>
                        <textarea name="translate[{$keyLanguage}]" class="form-control">{$value}</textarea>
                    </div>
                {/foreach}
                <div class="form-actions hide">
                    <div class="form-gropup">
                        <input type="submit" title="{'Validate translation'|i18n('owtranslate')}" value="{'Send traduction'|i18n('owtranslate')}" class="btn btn-success">
                        {*<input type="submit" title="{"Cancel translation"|i18n('owtranslate')}" onclick="return confirm( '{'Do you really want to cancel the translation?'|i18n('owtranslate')}' );" value="{"Cancel translation"|i18n('owtranslate')}" class="btn btn-warning">*}
                    </div>
                </div>

            </div>

        </form>
    </div>
    <div class="col-lg-1 col-sm-2">
        <div class="affix-wrapper">
            <ul class="actions-nav">
                <li>
                    <a href="#" onclick="ezpopmenu_submitForm( 'translation-form' ); return false;">
                        <i class="fa fa-check"></i>
                        <p>{"Save"|i18n( 'design/standard/content/edit' )}</p>
                    </a>
                </li>
                <li>
                    <a href="#" onclick="javascript:history.back()">
                        <i class="fa fa-times"></i>
                        <p>{"Discard"|i18n( 'design/standard/content/edit' )}</p>
                    </a>
                </li>
            </ul>
        </div>
    </div>
{/if}
{undef}
