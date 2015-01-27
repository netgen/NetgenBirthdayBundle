{ezcss_require( 'comment.css' )}
    {def $fields = ezini( 'FormSettings', 'AvailableFields', 'ezcomments.ini' )}
    {def $fieldRequiredText = '<span class="ezcom-field-mandatory">*</span>'}

<form name="CommentEdit">
    <h2>{"Edit comment"|i18n("scs/comment")}</h2>
    <input type="hidden" name="CommentID" value="{$comment.id}" />
    <div class="ezcom-edit">
        {if $fields|contains( 'title' )}
        {def $titleRequired = ezini( 'title', 'Required', 'ezcomments.ini' )|eq( 'true' )}
            <div class="hide">
                <div class="ezcom-field ezcom-field-title">
                    <label>
                        {'Title:'|i18n( 'ezcomments/comment/add/form' )}{if $titleRequired}{$fieldRequiredText}{/if}
                    </label>
                    <input type="text" class="form-control" maxlength="100" name="CommentTitle" value="{$comment.title|wash}" />
                </div>
            </div>
        {undef $titleRequired}
        {/if}

        {if $fields|contains( 'name' )}
        {def $nameRequired = ezini( 'name', 'Required', 'ezcomments.ini' )|eq( 'true' )}
            <div class="hide">
                <div class="ezcom-field ezcom-field-name">
                    <label>
                        {'Name:'|i18n( 'ezcomments/comment/add/form' )}{if $nameRequired}{$fieldRequiredText}{/if}
                    </label>
                     <input type="text" class="form-control" maxlength="50" name="CommentName" value="{$comment.name|wash}" />
                </div>
            </div>
        {undef $nameRequired}
        {/if}

        {if $fields|contains( 'website' )}
        {def $websiteRequired = ezini( 'website', 'Required', 'ezcomments.ini' )|eq( 'true' )}
            <div class="hide">
                <div class="ezcom-field ezcom-field-website">
                    <label>
                        {'Website:'|i18n( 'ezcomments/comment/add/form' )}{if $websiteRequired}{$fieldRequiredText}{/if}
                    </label>
                    <input type="text"
                           class="form-control"
                           maxlength="100"
                           name="CommentWebsite"
                           value="{$comment.url|wash}" />
                </div>
            </div>
        {undef $websiteRequired}
        {/if}

        {if $fields|contains( 'email' )}
        {def $emailRequired = ezini( 'email', 'Required', 'ezcomments.ini' )|eq( 'true' )}
            <div class="hide">
                <div class="ezcom-field ezcom-field-email">
                    <label>
                        {'Email:'|i18n( 'ezcomments/comment/add/form' )}{if $emailRequired}{$fieldRequiredText}{/if}
                    </label>
                    <input type="text"
                           class="form-control"
                           name="CommentEmail"
                           disabled="disabled"
                           value="{$comment.email|wash}" />
            </div>
            </div>
        {undef $emailRequired}
        {/if}
        <div class="form-group">
            <div class="ezcom-field ezcom-field-content">
                <label>
                    {'Content:'|i18n( 'ezcomments/comment/add/form' )}{$fieldRequiredText}
                </label>
                <textarea class="form-control" name="CommentContent" rows="" cols="">{$comment.text|wash}</textarea>
            </div>
        </div>
        {if $fields|contains( 'notificationField' )}
            {if $fields|contains( 'email' )}
                <div class="hide">
                    <div class="ezcom-field ezcom-field-notified">
                        <label>
                            <input type="checkbox"
                                   name="CommentNotified"
                                   {if $notified}checked="checked"{/if} value="1" />
                            {'Notified of new comments'|i18n( 'ezcomments/comment/add/form' )}
                        </label>
                    </div>
                </div>
            {/if}
        {/if}
        <div class="ezcom-field">
            <input type="button"
                   value="{'Update comment'|i18n('ezcomments/comment/action' )}"
                   class="btn btn-success"
                   name="UpdateCommentButton" />
            <input type="button"
                   value="{'Cancel'|i18n('ezcomments/comment/action' )}"
                   class="btn"
                   name="CancelButton" />
            <div class="edit-comment-loader" style="display:none"><img src={'ajax-loader-comments.gif'|ezimage} alt="{'Loading ...'|i18n( 'ngcomments/comment' )}" /></div>
        </div>
    </div>
    <hr>
</form>