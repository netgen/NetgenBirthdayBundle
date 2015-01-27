{ezcss_require( 'comment.css' )}
{if $attribute.content.show_comments}

    {if is_set( $attribute_node )|not()}
        {if is_set( $#node )}
            {def $attribute_node=$#node}
        {else}
            {def $attribute_node=false()}
        {/if}
    {/if}

    {def $contentobject = $attribute.object}
    {def $language_id = $attribute.object.current_language_object.id}
    {def $language_code = $attribute.language_code}
    {def $can_read = fetch( 'comment', 'has_access_to_function', hash( 'function', 'read',
                                                                       'contentobject', $contentobject,
                                                                       'language_code', $language_code,
                                                                       'node', $attribute_node ) )}
    {* Displaying comments START *}
    {if $can_read}
        {def $sort_field=ezini( 'GlobalSettings', 'DefaultEmbededSortField', 'ezcomments.ini' )}
        {def $sort_order=ezini( 'GlobalSettings', 'DefaultEmbededSortOrder', 'ezcomments.ini' )}
        {def $default_shown_length=ezini( 'GlobalSettings', 'DefaultEmbededCount', 'ezcomments.ini' )}

        {* Fetch comment count *}
        {def $total_count=fetch( 'comment',
                                 'comment_count',
                                 hash( 'contentobject_id', $contentobject.id,
                                       'language_id', $language_id,
                                       'status' ,1 ) )}

        {def $offset = $default_shown_length|mul($page)}

        {* Fetch comments *}
        {def $comments=fetch( 'comment',
                              'comment_list',
                              hash( 'contentobject_id', $contentobject.id,
                                    'language_id', $language_id,
                                    'sort_field', $sort_field,
                                    'sort_order', $sort_order,
                                    'offset', $offset,
                                    'length' ,$default_shown_length,
                                    'status', 1 ) )}

        {* Adding comment form START *}
        {if $is_reload|not}
            {if $attribute.content.enable_comment}
                {def $can_add = fetch( 'comment', 'has_access_to_function', hash( 'function', 'add',
                                                                               'contentobject', $contentobject,
                                                                               'language_code', $language_code,
                                                                               'node', $attribute_node
                                                                                ) )}
                {if $can_add}
                    {include uri="design:comment/add_comment.tpl" redirect_uri=$attribute_node.url_alias contentobject_id=$contentobject.id language_id=$language_id}
                {else}
                    <div class="message-error">
                            <p>
                                {'You don\'t have access to post comment.'|i18n( 'ezcomments/comment/view' )}
                            </p>
                    </div>
                {/if}
                {undef $can_add}
            {/if}
        {/if}
        {* Adding comment form END *}

        {* Find out if the currently used role has a user based edit/delete policy *}
        {def $self_policy=fetch( 'comment', 'self_policies', hash( 'contentobject', $contentobject, 'node', $attribute_node ) )}

        {* Comment item START *}
        {if $comments|count|gt( 0 )}
            {if $is_reload|not}
                <div class="reload-comments-loader" style="display:none">
                    <div class="comments-loading">
                        <p>{'Loading comments ...'|i18n( 'ngcomments/comment' )}</p>
                        <img src={'ajax-loader-bar-white.gif'|ezimage} alt="{'Loading comments ...'|i18n( 'ngcomments/comment' )}" />
                    </div>
                </div>
                <div class="action-message"></div>
            {/if}
            <hr>
            <div class="row">
                <div id="ezcom-comment-list" class="ezcom-view-list">
                        {for 0 to $comments|count|sub( 1 ) as $index}
                            {include contentobject=$contentobject
                                    language_code=$language_code
                                    comment=$comments.$index
                                    index=$index
                                    base_index=0
                                    can_self_edit=$self_policy.edit
                                    can_self_delete=$self_policy.delete
                                    node=$attribute_node
                                    uri="design:comment/view/comment_item.tpl"}
                        {/for}
                    <div class="ezcom-view-all">
                        <div class="ezcom-paging">
                            {def $number_of_pages = $total_count|div($default_shown_length)|ceil}
                            {if $number_of_pages|gt(1)}
                                {'Pages'|i18n( 'ngcomments/comment' )}:&nbsp;
                                {for 0 to $number_of_pages|dec as $curr}
                                    {if $curr|ne($page)}<a href="#" class="ezcom-paging-link" rel="{$curr}">{/if}{$curr|inc}{if $curr|ne($page)}</a>{/if}&nbsp;
                                {/for}
                            {/if}
                        </div>

                        <p>{'Total comment count'|i18n( 'ngcomments/comment' )}: <span class="ezcom-comment-count">{$total_count}</span></p>
                    </div>
                </div>
            </div>
        {else}
            <div id="ezcom-comment-list" class="ezcom-view-list"></div>
        {/if}
        {* Comment item END *}

        {undef $comments $total_count $default_shown_length $sort_order $sort_field }
    {else}
        <div class="message-error">
            <p>
                    {'You don\'t have access to view comment.'|i18n( 'ezcomments/comment/view' )}
            </p>
        </div>
    {/if}
    {undef $can_read}
    {* Displaying comments END *}

    {undef $contentobject $language_id $language_code}
{/if}
