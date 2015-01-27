{if $tag.synonyms_count|gt( 0 )}
    <table class="table table-striped table-bordered" cellpadding="0">
        <tbody>
            <tr>
                <th>{"ID"|i18n( "dms/tags" )}</th>
                <th>{"Name"|i18n( "dms/tags" )}</th>
                <th>{"Modified"|i18n( "dms/tags" )}</th>
            </tr>
            {foreach $tag.synonyms as $synonym}
                <tr>
                    <td>{$synonym.id}</td>
                    <td><a href={concat( 'tags/id/', $synonym.id )|ezurl} title="{$synonym.keyword|wash}">{$synonym.keyword|wash}</a></td>
                    <td>{$synonym.modified|datetime( 'custom', '%d.%m.%Y %H:%i' )}</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
{else}
    <p>{"No synonyms"|i18n( "dms/tags" )}</p>
{/if}
