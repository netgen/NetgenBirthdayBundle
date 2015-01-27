{*?template charset=UTF-8*}
{ezscript_require(array('jquery.jeditable.js', 'owtranslate.js'))}
{ezcss_require(array('owtranslate.css'))}
{*if $numberTotal|not|and( ezhttp_hasvariable( 'todo', 'get' )|not )*}

{*else*}

	{def
	    $localeGet    = false()
	    $sourceKeyGet = false()
	    $dataKeyGet   = false()
	}
	{if ezhttp_hasvariable( 'sourceKey', 'get' )}
	    {set $sourceKeyGet = ezhttp( 'sourceKey', 'get' )}
	{else}
	    {set $sourceKeyGet = $sourceKey}
	{/if}

	<div class="box">
		<div class="box-header">
		    <div class="button-left">
		    	<h2><i class="fa fa-file-text"></i>{'Translator / List'|i18n('owtranslate')}</h2>
		    </div>
		</div>
		<div class="box-content">
			<div class="search-form well">
				{include uri='design:translate/parts/searchtranslationform.tpl'}
		    </div>
	    </div>
	</div>

	<div class="box">
	    <div class="box-header">
	        <div class="box-tr">
	        	<h2><i class="fa fa-file-text"></i>{$numberTotal}&nbsp;{'translations'|i18n('owtranslate')}</h2>
	        </div>
	    </div>

	    <div class="box-content">
			{*include uri='design:translate/parts/toptoolbar.tpl' view='list'*}
	        <div class="content-navigation-childlist">
				{if is_set($dataList)}
			        {include uri='design:translate/parts/translationtable.tpl'}
				{/if}
       	 	</div>

       	 	{if and(is_set($numberTotal), gt($numberTotal, $limit))}

				<div class="context-toolbar">
					{include name=navigator
				         uri='design:navigator/google.tpl'
				         page_uri='/translate/list'
				         item_count=$numberTotal
				         view_parameters=$view_parameters
				         item_limit=$limit}
				</div>
			{/if}

   	 	</div>
   	 </div>


	</div>
	{undef}
{*/if*}
