{def $latest_tags = fetch( tags, latest_tags, hash( parent_tag_id, first_set( $tag.id, 0 ), limit, 10 ) )}

{if $latest_tags|count}
    <table class="table table-striped table-bordered" cellpadding="0">
        <tbody>
            <tr>
                <th>{"ID"|i18n( "dms/tags" )}</th>
                <th>{"Tag name"|i18n( "dms/tags" )}</th>
                <th>{"Parent tag name"|i18n( "dms/tags" )}</th>
                <th>{"Modified"|i18n( "dms/tags" )}</th>
            </tr>
            {foreach $latest_tags as $t}
                <tr>
                    <td>{$t.id}</td>
                    <td><a href={concat( 'tags/id/', $t.id )|ezurl} title="{$t.keyword|wash}">{$t.keyword|wash}</a></td>
                    {if $t.parent}
                        <td>{$t.parent.keyword|wash}</td>
                    {else}
                        <td>{"No parent"|i18n( "dms/tags" )}</td>
                    {/if}
                    <td>{$t.modified|datetime( 'custom', '%d.%m.%Y %H:%i' )}</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
{else}
    <p>{"No tags"|i18n( "dms/tags" )}</p>
{/if}
