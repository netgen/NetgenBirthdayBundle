(function($) {
    var ngComments = function(options) {
        var defaults = {},

        addComment = function(w, trigger) {
            var P = w.data('ngComments').p;

            if (P.object_id && P.language_code) {
                P.add_comment_loader.show();
                if(P.title) P.title.attr('disabled', 'disabled');
                if(P.name) P.name.attr('disabled', 'disabled');
                if(P.website) P.website.attr('disabled', 'disabled');
                if(P.email) P.email.attr('disabled', 'disabled');
                if(P.comment) P.comment.attr('disabled', 'disabled');
                if(P.recaptcha) P.recaptcha.attr('disabled', 'disabled');
                if(P.notified) P.notified.attr('disabled', 'disabled');
                if(P.rememberme) P.rememberme.attr('disabled', 'disabled');
                trigger.attr('disabled', 'disabled');

                var post_data = {};
                post_data['ContentObjectID'] = P.object_id;
                post_data['CommentLanguageCode'] = P.language_code;
                if(P.title) post_data['CommentTitle'] = P.title.val();
                if(P.name) post_data['CommentName'] = P.name.val();
                if(P.website) post_data['CommentWebsite'] = P.website.val();
                if(P.email) post_data['CommentEmail'] = P.email.val();
                if(P.comment) post_data['CommentContent'] = P.comment.val();
                if(P.recaptcha) post_data['recaptcha_response_field'] = P.recaptcha.val();
                var recaptcha_challenge = (w.find('[name="recaptcha_challenge_field"]').length > 0) ? w.find('[name="recaptcha_challenge_field"]') : false;
                if(recaptcha_challenge) post_data['recaptcha_challenge_field'] = recaptcha_challenge.val();
                if(P.notified && P.notified.attr('checked')) post_data['CommentNotified'] = '1';
                if(P.rememberme && P.rememberme.attr('checked')) post_data['CommentRememberme'] = '1';

                $.ez('ezjscNgComments::addComment', post_data, function(data) {
                    if (data.content.status == 'success') {
                        var new_comment = $(data.content.content);
                        addOwnerMarkup(w, new_comment);
                        P.comment_list.prepend(new_comment);

                        if(P.title) P.title.val('');
                        if(P.comment) P.comment.val('');
                        P.comment_count.html((parseInt(P.comment_count.html()) + 1).toString());
                        showActionMessage(w, data.content.message);
                    }
                    else {
                        alert(data.content.message);
                    }

                    P.add_comment_loader.hide();
                    if(P.title) P.title.removeAttr('disabled');
                    if(P.name) P.name.removeAttr('disabled');
                    if(P.website) P.website.removeAttr('disabled');
                    if(P.email) P.email.removeAttr('disabled');
                    if(P.comment) P.comment.removeAttr('disabled');
                    if(P.recaptcha) P.recaptcha.removeAttr('disabled');
                    if(P.notified) P.notified.removeAttr('disabled');
                    if(P.rememberme) P.rememberme.removeAttr('disabled');
                    trigger.removeAttr('disabled');
                    Recaptcha.reload();
                });
            }
        },

        deleteComment = function(w, trigger, delete_comment_message) {
            if (confirm(delete_comment_message)) {
                var P = w.data('ngComments').p;
                var comment_id = trigger.closest('.ezcom-view-comment').find('[name="CommentID"]').val();

                if(comment_id) {
                    var comment_container = trigger.closest('.ezcom-view-comment');
                    var comment_loader = comment_container.find('.comment-loader');
                    var edit_comment_button = comment_container.find('[name="EditCommentButton"]');

                    comment_loader.show();
                    edit_comment_button.attr('disabled', 'disabled');
                    trigger.attr('disabled', 'disabled');

                    $.ez('ezjscNgComments::deleteComment', {'CommentID': comment_id}, function(data) {
                        if (data.content.status == 'success') {
                            comment_container.slideUp(250, function(){ $(this).remove(); });
                            P.comment_count.html((parseInt(P.comment_count.html()) - 1).toString());
                            showActionMessage(w, data.content.message);
                        }
                        else {
                            alert(data.content.message);
                            edit_comment_button.removeAttr('disabled');
                            trigger.removeAttr('disabled');
                            comment_loader.hide();
                        }
                    });
                }
            }
        },

        editComment = function(w, trigger) {
            var comment_id = trigger.closest('.ezcom-view-comment').find('[name="CommentID"]').val();

            if (comment_id) {
                var comment_container = trigger.closest('.ezcom-view-comment');
                var comment_item = comment_container.find('.ezcom-view-comment-item');
                var comment_controls = comment_container.find('.ezcom-comment-tool');
                var comment_loader = comment_container.find('.comment-loader');

                comment_loader.show();

                $.ez('ezjscNgComments::editCommentLoad', {'CommentID': comment_id}, function(data) {
                    if (data.content.status == 'success') {
                        comment_item.hide();
                        comment_controls.hide();
                        comment_container.append(data.content.content);
                    }
                    else {
                        alert(data.content.message);
                    }

                    comment_loader.hide();
                });
            }
        },

        editCommentCancel = function(w, trigger) {
            var comment_container = trigger.closest('.ezcom-view-comment');
            comment_container.find('.ezcom-view-comment-item').show();
            comment_container.find('.ezcom-comment-tool').show();
            comment_container.find('[name="CommentEdit"]').remove();
            return false;
        },

        editCommentSubmit = function(w, trigger, missing_input_message) {
            var comment_container = trigger.closest('.ezcom-view-comment');
            var edit_comment_container = comment_container.find('[name="CommentEdit"]');

            var edit_comment_loader = edit_comment_container.find('.edit-comment-loader');
            var edit_comment_cancel = edit_comment_container.find('[name="CancelButton"]');

            var comment_id = edit_comment_container.find('[name="CommentID"]');
            comment_id = (comment_id.length > 0 && comment_id.val()) ? comment_id.val() : false;

            var title                   = (edit_comment_container.find('[name="CommentTitle"]').length > 0) ? edit_comment_container.find('[name="CommentTitle"]') : false;
            var name                    = (edit_comment_container.find('[name="CommentName"]').length > 0) ? edit_comment_container.find('[name="CommentName"]') : false;
            var website                 = (edit_comment_container.find('[name="CommentWebsite"]').length > 0) ? edit_comment_container.find('[name="CommentWebsite"]') : false;
            var email                   = (edit_comment_container.find('[name="CommentEmail"]').length > 0) ? edit_comment_container.find('[name="CommentEmail"]') : false;
            var comment                 = (edit_comment_container.find('[name="CommentContent"]').length > 0) ? edit_comment_container.find('[name="CommentContent"]') : false;
            var notified                = (edit_comment_container.find('[name="CommentNotified"]').length > 0) ? edit_comment_container.find('[name="CommentNotified"]') : false;

            if (comment_id) {
                edit_comment_loader.show();
                if(title) title.attr('disabled', 'disabled');
                if(name) name.attr('disabled', 'disabled');
                if(website) website.attr('disabled', 'disabled');
                if(email) email.attr('disabled', 'disabled');
                if(comment) comment.attr('disabled', 'disabled');
                if(notified) notified.attr('disabled', 'disabled');
                edit_comment_cancel.attr('disabled', 'disabled');
                trigger.attr('disabled', 'disabled');

                var post_data = {};
                post_data['CommentID'] = comment_id;
                if(title) post_data['CommentTitle'] = title.val();
                if(name) post_data['CommentName'] = name.val();
                if(website) post_data['CommentWebsite'] = website.val();
                if(email) post_data['CommentEmail'] = email.val();
                if(comment) post_data['CommentContent'] = comment.val();
                if(notified && notified.attr('checked')) post_data['CommentNotified'] = '1';

                $.ez('ezjscNgComments::editComment', post_data, function(data) {
                    if (data.content.status == 'success') {
                        var new_comment = $(data.content.content);
                        addOwnerMarkup(w, new_comment);
                        comment_container.replaceWith(new_comment);
                        showActionMessage(w, data.content.message);
                    }
                    else {
                        alert(data.content.message);
                        if(title) title.removeAttr('disabled');
                        if(name) name.removeAttr('disabled');
                        if(website) website.removeAttr('disabled');
                        if(email) email.removeAttr('disabled');
                        if(comment) comment.removeAttr('disabled');
                        if(notified) notified.removeAttr('disabled');
                        edit_comment_cancel.removeAttr('disabled');
                        trigger.removeAttr('disabled');
                        edit_comment_loader.hide();
                    }
                });
            }
        },

        reloadComments = function(w, trigger, page) {
            var comments_loader = $('#comment-container').find('.reload-comments-loader');
            var comments_list = $('#comment-container').find('#ezcom-comment-list');

            var object_attribute_id = w.find('[name="ObjectAttributeID"]');
            if (object_attribute_id.length > 0 && object_attribute_id.val())
                object_attribute_id = object_attribute_id.val();

            var version = w.find('[name="Version"]');
            if (version.length > 0 && version.val())
                version = version.val();

            if (object_attribute_id && version) {
                comments_list.remove();
                comments_loader.show();

                $.ez('ezjscNgComments::commentList', {'attribute_id': object_attribute_id,
                        'version': version, 'page': page, 'is_reload': '1'}, function(data){
                    if(data.content.status == 'success')
                        jQuery('#comment-container').append(data.content.content).ngComments();
                    else
                        jQuery('#comment-container').append(data.content.message);

                    comments_loader.hide();
                });
            }
        },

        addOwnerMarkup = function(w, comment) {
            var opt = w.data('ngComments');
            if (comment.hasClass(opt.p.uoid)) {
                comment.find("li").append(opt.p.owner_controls);
            }
        },

        showActionMessage = function(w, message) {
            var P = w.data('ngComments').p;
            P.action_message.html(message).css('color', '#C70000');
        };

        return {
            init: function(opt) {
                opt = $.extend({}, defaults, opt||{});
                return this.each(function() {
                    var w = $(this);

                    opt.p = {};
                    opt.p.uoid                      = w.find('[name="UserObjectID"]').val();
                    opt.p.object_id                 = w.find('[name="ContentObjectID"]').val();
                    opt.p.language_code             = w.find('[name="CommentLanguageCode"]').val();
                    opt.p.missing_input_message     = w.find('[name="MissingInputMessage"]').val();
                    opt.p.delete_comment_message    = w.find('[name="DeleteCommentMessage"]').val();
                    opt.p.delete_button_text        = w.find('[name="DeleteButtonText"]').val();
                    opt.p.edit_button_text          = w.find('[name="EditButtonText"]').val();
                    opt.p.action_message            = w.find('.action-message');
                    opt.p.add_comment_loader        = w.find('.add-comment-loader');
                    opt.p.comment_list              = w.find('#ezcom-comment-list');
                    opt.p.comment_count             = w.find('.ezcom-comment-count');

                    opt.p.title                     = (w.find('[name="CommentTitle"]').length > 0) ? w.find('[name="CommentTitle"]') : false;
                    opt.p.name                      = (w.find('[name="CommentName"]').length > 0) ? w.find('[name="CommentName"]') : false;
                    opt.p.website                   = (w.find('[name="CommentWebsite"]').length > 0) ? w.find('[name="CommentWebsite"]') : false;
                    opt.p.email                     = (w.find('[name="CommentEmail"]').length > 0) ? w.find('[name="CommentEmail"]') : false;
                    opt.p.comment                   = (w.find('[name="CommentContent"]').length > 0) ? w.find('[name="CommentContent"]') : false;
                    opt.p.recaptcha                 = (w.find('[name="recaptcha_response_field"]').length > 0) ? w.find('[name="recaptcha_response_field"]') : false;
                    opt.p.notified                  = (w.find('[name="CommentNotified"]').length > 0) ? w.find('[name="CommentNotified"]') : false;
                    opt.p.rememberme                = (w.find('[name="CommentRememberme"]').length > 0) ? w.find('[name="CommentRememberme"]') : false;

                    opt.p.owner_controls = '<div class="ezcom-comment-tool float-break pull-right">' +
                        '<input type="button" class="btn btn-danger" name="DeleteCommentButton" value="' + opt.p.delete_button_text + '" />' +
                        '<input type="button" class="btn" name="EditCommentButton" value="' + opt.p.edit_button_text + '" />' +
                        '<div class="comment-loader" style="display:none"><img src="/extension/ngcomments/design/standard/images/ajax-loader-comments.gif" alt="Loading ..." /></div>' +
                    '</div>';

                    var P = opt.p;
                    w.data('ngComments', opt);

                    w.find('[name="AddCommentButton"]').live('click', function() {
                        addComment(w, $(this)); return false;
                    });

                    w.find('[name="DeleteCommentButton"]').live('click', function() {
                        deleteComment(w, $(this), opt.p.delete_comment_message); return false;
                    });

                    w.find('[name="EditCommentButton"]').live('click', function() {
                        editComment(w, $(this)); return false;
                    });

                    w.find('[name="CancelButton"]').live('click', function() {
                        editCommentCancel(w, $(this)); return false;
                    });

                    w.find('[name="UpdateCommentButton"]').live('click', function() {
                        editCommentSubmit(w, $(this), opt.p.missing_input_message); return false;
                    });

                    w.find('.ezcom-paging-link').live('click', function() {
                        reloadComments(w, $(this), $(this).attr('rel')); return false;
                    });

                    w.find('#ezcom-comment-list .ezcom-view-comment').each(function() {
                        addOwnerMarkup(w, $(this));
                    });
                });
            }
        };
    }();

    $.fn.extend({
        ngComments: ngComments.init
    });
})(jQuery);
