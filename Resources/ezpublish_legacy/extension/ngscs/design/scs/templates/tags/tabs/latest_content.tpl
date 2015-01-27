{def $nodes = fetch( content, tree, hash( parent_node_id, 2,
                                          extended_attribute_filter,
                                          hash( id, TagsAttributeFilter,
                                                params, hash( tag_id, $tag.id, include_synonyms, false() ) ),
                                          limit, 10,
                                          main_node_only, true(),
                                          sort_by, array( modified, false() ) ) )}



{if $nodes|count}
    <table class="table table-striped table-bordered">
        <thead>
            <tr>
                <th width="33%">{"Title"|i18n( 'dms/tags' )}</th>
                <th>{"Status"|i18n( 'dms/tags' )}</th>
                <th>{"Creator of dossier"|i18n( 'dms/tags' )}</th>
                <th>{"Modification date"|i18n( 'dms/tags' )}</th>

            </tr>
        </thead>
        <tbody>
            {def $group_state_array=array()}
            {def $status_state_identifier = ''}
            {def $status_state = ''}
            {foreach $nodes as $child}
                {* reset all state variables *}
                {set $group_state_array=array()}
                {set $status_state_identifier = ''}
                {set $status_state = ''}

                {*get selected status state identifier*}
                {foreach $child.object.state_identifier_array as $selected_group_state}
                    {set $group_state_array = $selected_group_state|explode('/')}
                    {if $group_state_array.0|eq('rgm_status')}
                        {set $status_state_identifier = $group_state_array.1}
                        {break}
                    {/if}
                {/foreach}
                {* get selected status stae name *}
                {foreach $child.object.allowed_assign_state_list as $group_state}
                    {if $group_state.group.identifier|eq('rgm_status')}
                        {foreach $group_state.group.states as $available_state}
                            {if $available_state.identifier|eq($status_state_identifier)}
                                {set $status_state = $available_state.current_translation.name}
                                {break}
                            {/if}
                        {/foreach}
                        {break}
                    {/if}
                {/foreach}
                <tr>
                    <td width="33%"><a href={concat("content/view/full/",$child.node_id)|ezurl} title="{$child.name|wash}">{$child.name|wash}</a></td>
                    <td>{$status_state|d18n('dms/tags')}</td>
                    <td>{$child.object.owner.name|wash}</td>
                    <td>{$child.object.modified|l10n(shortdate)}</td>
                </tr>
            {/foreach}
            <tr>
            </tr>
        </tbody>
    </table>
{else}
    <p>{"No content"|i18n( 'dms/tags' )}</p>
{/if}

{undef}
