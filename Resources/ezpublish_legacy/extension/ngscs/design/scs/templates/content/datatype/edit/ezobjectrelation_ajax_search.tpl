{run-once}
{if ezmodule( 'ezjscore' )}{* Make sure ezjscore is installed before we try to enable the search code *}
<input type="hidden" id="ezobjectrelation-search-published-text" value="{'Yes'|i18n( 'dms/content/relation_list' )}" />
<p id="ezobjectrelation-search-empty-result-text" class="hide ezobjectrelation-search-empty-result">{'No results were found when searching for "%1"'|i18n("dms/content/relation_list",,array( '--search-string--' ))}</p>
{ezscript_require( 'ezajaxrelations_jquery.js' )}
{/if}
{/run-once}