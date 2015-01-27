/*global mceButtonsTitleOverride */

(function(){
    var rgmAjax = function(options){
        this.classIdentifier = options.classIdentifier || '';

        if(this.constructor.all[this.classIdentifier]){
            return false;
        }

        this.iframeSetupEnabled = (this.classIdentifier == 'file' || this.classIdentifier == 'private_file')? true : false;

        this.MainNodeId = options.MainNodeId;
        this.ObjectID = options.ObjectID;
        this.ActionName = options.ActionName;
        this.SortByAttribute = options.SortByAttribute;
        this.ShowBottomControls = options.ShowBottomControls;
        this.enableMyDebug = options.enableMyDebug || false;
        this.contentWrapper = '#' + this.classIdentifier + '-ezajaxcontent';
        this.newContentSelector = options.newContentSelector || '#' + this.classIdentifier + '-new-content';
        this.viewContentSelector = options.viewContentSelector || '#' + this.classIdentifier + '-view-content';
        this.layout = options.layout;
        this.ajaxTextHTML = options.ajaxTextHTML || 'Please wait until page loads';

        this.setup_events();
        this.init();
        this.register();

        return this;
    };

    rgmAjax.all = {};

    rgmAjax.prototype.register = function() {
        this.constructor.all[this.classIdentifier] = true;
    };

    rgmAjax.prototype.init = function() {
        var that = this;
        var query = {
          ObjectID: this.ObjectID,
          ClassIdentifier: this.classIdentifier,
          ActionName: this.ActionName,
          ShowBottomControls: this.ShowBottomControls
        };

        if(this.SortByAttribute){
            query.SortByAttribute = this.SortByAttribute;
        }
        if(this.layout){
            query.Layout = this.layout;
        }

        $.ez( 'ngajaxcrud::display',query, function( data ){
          that.ajax_settings = this;
          var $el = $( '#' + that.classIdentifier + '-ezajaxcontent' );
          if ( data.error_text ){
            $el.html( data.error_text );
          }else{
            $el.html( data.content );
            $( '#' + that.classIdentifier + '-view-content .content-view-line:nth-child(2n-1)' ).addClass( 'even' );
          }

          that.tabsInit(that.viewContentSelector);
          that.completeDetect(this);

        });
    };

    rgmAjax.prototype.setup_events = function(){

        var that = this;
        $(this.contentWrapper).on('click', '.NewAjaxContent', function(e){
            e.preventDefault();
            console.log("New Action clicked");
            that.newContent(this);
            that.afterContentLoadSetup(that);
        }).on('click', "input[name=PublishButton]", function(e){
            if(that.iframeSetupEnabled){
                /*if(!$(that.newContentSelector).find('iframe').contents().find('div.warning').length ){
                    $(that.newContentSelector).empty();
                    that.toggleActionButtons();
                    that.getSubtree();
                    console.log('warning detected');
                }*/


                //trigger iframe listener for file/private_file class
                //that.iframeSetup(that.newContentSelector);

            }else{
                e.preventDefault();
                that.publish(this);
            }
        }).on('click', "input[name=DiscardButton]", function(e){
            e.preventDefault();
            console.log("discard clicked");
            that.discard(this);
        }).on('click', "input[name=ActionRemove]", function(e){
            e.preventDefault();
            that.remove(this);
        }).on('click', "input[name=CancelButton]", function(e){
            e.preventDefault();
            that.removeCancel(this);
        }).on('click', "input[name=ConfirmButton]", function(e){
            e.preventDefault();
            that.removeConfirm(this);
        }).on('click', "input[name=EditButton]", function(e){
            e.preventDefault();
            that.edit(this);
            //trigger functions for hide editor button, override title
            that.afterContentLoadSetup(that);

        }).on('click', "input.ezobject-relation-add-button, input.ezobject-relation-remove-button, a[href^='/layout/set/ajax'], input[name=SelectButton], input[name=BrowseCancelButton]", function(e){
            e.preventDefault();
            console.log(e.target);
            that.relationBrowse(this);
            //trigger functions for hide editor button, override title
            //that.afterContentLoadSetup(that);

        }).on('ajaxComplete', function(e, xhr, settings ){
            e.preventDefault();
            //console.log('[Setup_events] Ajax complete detect');
            //that.completeDetect(settings);
        });
    };

    rgmAjax.prototype.afterContentLoadSetup = function(that){

        $(that.contentWrapper).on('ajaxComplete', function(e, xhr, settings ){
            e.preventDefault();
            //console.log('[afterContentLoadSetup] Ajax complete detect');


            //if (settings.data.indexOf("fillSelect") < 0 ){
                // Checking if function is defined the call that function
                /*if( typeof tagSelectInit == 'function' ){
                    tagSelectInit();
                }else{
                    that.myDebug( "[Error] tagSelectInit() is not defined. Please include tag_select.js file", "red");
                }*/
                //Disable editor
                $('input[name$="disable_editor]"]').hide();
            //}

            that.mceButtonsTitleOverride();
        });
    };

    rgmAjax.prototype.newContent = function( buttonElement, hideElementID )
    {
        var newContentElementID = this.newContentSelector;

        var formElement = buttonElement.form;
        var url = formElement.action;

        url = url.replace( '/content/action', '/layout/set/ajax/content/action' );

        var data = $(formElement).serializeArray();
        data.push( { name: buttonElement.name, value: 1 } );

        //this.toggleActionButtons();

        if ( hideElementID ){ $( hideElementID ).hide();}

        var newContentElement = $( newContentElementID ).length ? $( newContentElementID ) : $('<div/>').attr('id', this.classIdentifier + '-new-content').appendTo(this.contentWrapper);

        /* Copy content from article to new amendmend */
        if ( $('input[name=AjaxCopyContent]', formElement).length > 0 )
        {
            var copyContentEnabled = true;
            var ajaxContent_name = $('input[name=AjaxContent_name]', formElement).attr('value');
            var ajaxContent_number = $('input[name=AjaxContent_number]', formElement).attr('value');
            var ajaxContent_text = $('input[name=AjaxContent_text]', formElement).attr('value');
            var ajaxContent_subjectTagIDs = $('input[name=AjaxContent_subjectTagIDs]', formElement).attr('value');
            var ajaxContent_subjectTagPIDs = $('input[name=AjaxContent_subjectTagPIDs]', formElement).attr('value');
            var ajaxContent_subjectTagNames = $('input[name=AjaxContent_subjectTagNames]', formElement).attr('value');
            var ajaxContent_subjectTagLocales = $('input[name=AjaxContent_subjectTagLocales]', formElement).attr('value');
        }

        newContentElement.html( this.ajaxTextHTML );

        var that = this;
        newContentElement.load( url, data, function(response, status, xhr) {
            if ( status != "error" && copyContentEnabled ) {
                /* Paste content from article to new amendmend */

                $(that.newContentSelector + " input.ezcca-article_amended_ld_title").val( ajaxContent_name );
                $(that.newContentSelector + " input.ezcca-article_amended_ld_number").val( ajaxContent_number );
                $(that.newContentSelector + " .oe-window textarea").html( ajaxContent_text );

                $(that.newContentSelector + " .attribute-subject input.tagids").val( ajaxContent_subjectTagIDs );
                $(that.newContentSelector + " .attribute-subject input.tagpids").val( ajaxContent_subjectTagPIDs );
                $(that.newContentSelector + " .attribute-subject input.tagnames").val( ajaxContent_subjectTagNames );
                $(that.newContentSelector + " .attribute-subject select.tag_select").val( ajaxContent_subjectTagIDs );
                $(that.newContentSelector + " .attribute-subject input.taglocales").val( ajaxContent_subjectTagLocales );
            }

            //trigger iframe listener for file/private_file class
            //that.iframeSetup(that.newContentSelector);
            /*if(self.iframeSetupEnabled){
                $(this).find('iframe').load(function(event){
                    var iframe_content = $(this).contents().find('html').text();
                    if(iframe_content === ""){return;} //this is first on load in IE
                    self.iframeSetup(this, event);
                });
            }*/

        });

        /////////////////////
        this.scrollToAnchor(newContentElementID);
        ///////////////////////

        return false;
    };

    rgmAjax.prototype.discard = function(buttonElement) {

        var formElement = buttonElement.form;
        var url = formElement.getAttribute("action");//.action;
        var data = $(formElement).serializeArray();

        data.push( { name: buttonElement.name, value: 1 });

        var $editContainer = $(formElement).closest('.editContainer');
        var newContentElement =  $editContainer.length  ? $editContainer : $( this.newContentSelector );

        var that = this;

        newContentElement.html(this.ajaxTextHTML).load( url, data,function(response, status, xhr) {
            newContentElement.remove();
            //that.toggleActionButtons();
            //that.getSubtree();
        });

    };


    rgmAjax.prototype.publish = function(buttonElement) {

        var formElement = buttonElement.form;
        var url = formElement.action;
        var data = $(formElement).serializeArray();

        data.push( { name: buttonElement.name, value: 1 });

        var newContentElement = $( this.newContentSelector );

        var that = this;

        newContentElement.html(this.ajaxTextHTML).load( url, data,function(response, status, xhr) {
          if(!newContentElement.find('div.warning').length){
            newContentElement.empty();
            that.toggleActionButtons();
            that.getSubtree();
          }
        });
    };

    rgmAjax.prototype.edit = function(buttonElement) {
        var that = this;
        this.toggleActionButtons();

        var id = $(buttonElement).closest('.content-view-line').data('id');
        var $el = $('#obid-'+ id);

        if ( $el.length == 0 ){
            $el = $(buttonElement).closest('.editContainer').prev();
        }

        var formElement = buttonElement.form;
        var url = formElement.action;

        url = url.replace( '/content/action', '/layout/set/ajax/content/action' );

        var data = $(formElement).serializeArray();
        data.push( { name: buttonElement.name, value: 1 } );

        if($el.get(0).nodeName.toLowerCase() == 'tr'){
            var $editContainer = $(formElement).closest('.editContainer').length ? $(formElement).closest('.editContainer'):$('<tr/>').addClass('editContainer');
            var $td = $('<td/>').attr('colspan', 12).append( this.ajaxTextHTML ).load( url, data, function(){
                //that.iframeSetup('#obid-'+ id);
            });
            $editContainer.html($td);

            $el.after($editContainer);
        }else{
            var $editContainer = $(formElement).closest('.editContainer').length ? $(formElement).closest('.editContainer'):$('<div class="editContainer"></div>');
            $editContainer.appendTo($el).append( this.ajaxTextHTML ).load( url, data, function(){
            //that.iframeSetup('#obid-'+ id);
        });
        }

    };

    rgmAjax.prototype.relationBrowse = function(buttonElement) {
        var that = this, url;
        if (buttonElement.nodeName.toLowerCase() == 'a'){
            url = buttonElement.href;
            console.log("in AAA");
        }else{
            var formElement = buttonElement.form;
            url = formElement.action;
            url = url.replace( '/content/action', '/layout/set/ajax/content/action' );
            var data = $(formElement).serializeArray();
            // remove ajaxPassTrough suffix from input button
            data.push( { name: buttonElement.name, value: 1 } );
        }

        var $modalContainer = $('#modal_' +$( buttonElement).closest('div[id^=ezobjectrelation_browse_]').attr('id') );//"#modal_ezobjectrelation_browse_1234" );
        var $modalContent = $( "#" + $modalContainer.attr('id') + " .modal-body" );
        var $returnedContentContainer = $(formElement).closest('#edit-content').parent();

        //var $editContainer = $(formElement).closest('#rgm_process_step-new-content').length ? $(formElement).closest('#rgm_process_step-new-content'):$('<div class="editContainer"></div>');
        if (buttonElement.name=='SelectButton' || $(buttonElement).hasClass('ezobject-relation-remove-button')){
            //$( this.newContentSelector ).html( this.ajaxTextHTML ).load( url, data, function(){});
            $modalContainer.modal('hide');
            setTimeout(function(){

                $returnedContentContainer.empty().html( that.ajaxTextHTML ).load( url, data);
            }, 500);
        }else if(buttonElement.name == 'BrowseCancelButton'){
            $modalContainer.modal('hide');
        }else{
            $modalContainer.modal('show');
            console.log("display in this",$modalContent );
            $modalContent.html( this.ajaxTextHTML ).load( url, data, function(){});
        }

    }

    rgmAjax.prototype.remove = function(buttonElement) {
        this.toggleActionButtons();

        var id = $(buttonElement).closest('.content-view-line').data('id');
        var deleteContentElement = $('#obid-'+ id);

        var formElement = buttonElement.form;
        var url = formElement.action;

        url = url.replace( '/content/action', '/layout/set/ajax/content/action' );

        var data = $(formElement).serializeArray();
        data.push( { name: buttonElement.name, value: 1 } );
        $('<div class="deleteContainer"></div>').appendTo(deleteContentElement).append( this.ajaxTextHTML ).load( url, data);
    };

    rgmAjax.prototype.removeCancel = function(buttonElement){
        $(buttonElement).closest(".deleteContainer").remove();
        this.toggleActionButtons();
    };

    rgmAjax.prototype.removeConfirm = function(buttonElement){

        var that = this;

        var id = $(buttonElement).closest('.content-view-line').data('id');
        var $el = $('#obid-'+ id);
        var formElement = buttonElement.form;
        var url = formElement.action;
        var data = $(formElement).serializeArray();
        data.push( { name: buttonElement.name, value: 1 } );

        $el.html(this.ajaxTextHTML).load( url, data, function(response, status, xhr) {
            //remove div with content
            $el.remove();
            //remove tab item
            //$navEl.remove();
            //refresh the Subtree content
            that.getSubtree();
        });

        that.toggleActionButtons();
    };

    rgmAjax.prototype.completeDetect = function(settings)
    {
        //var that = this;
        //if (settings.data.indexOf("fillSelect") < 0 ){
            //that.myDebug("Ajax request detected[" + that.classIdentifier + "] ! ! !", "purple");
            //that.myDebug("Content selector is: " + that.newContentSelector , "purple");

            // Checking if function is defined the call that function
            /*if( typeof tagSelectInit == 'function' ){
                tagSelectInit();
            }else{
                that.myDebug( "[Error] tagSelectInit() is not defined. Please include tag_select.js file", "red");
            }*/

            // Display number of elements
            //that.myDebug("count elements in ajaxComplete", "purple");
            this.countElements();

            //Disable editor
            //$('input[name$="disable_editor]"]').hide();
        //}

        this.mceButtonsTitleOverride();
    };

     /*
     * Returns param value from URL string
     */
    rgmAjax.prototype.getDataParam = function( sParam, data ){
        var sURLVariables = data.split('&');
        for (var i = 0; i < sURLVariables.length; i++){
            var sParameterName = sURLVariables[i].split('=');
            if (sParameterName[0] == sParam){
                return sParameterName[1];
            }
        }
        return false;
    };

    rgmAjax.prototype.countElements = function(){
        if ( $('#main-tabs').find('li#tabitem-mixed_files').length >0){
            var filecount = parseInt($('#file-view-content div.line-wrapper').length, 10);
            var privatefilecount = parseInt($('#private_file-view-content div.line-wrapper').length, 10);
            $('#tabitem-mixed_files .live-counter').html( "[" + (filecount + privatefilecount) + "]" );
        }else{
            $('#tabitem-' + this.classIdentifier + ' .live-counter').html( "[" + $(this.viewContentSelector + ' div.line-wrapper').length + "]" );
        }
    };

    rgmAjax.prototype.scrollToAnchor = function(aid){
        var aTag = $(aid);
        if (aTag.length)
            $('html,body').animate({scrollTop: aTag.offset().top},'slow');
    };

    rgmAjax.prototype.toggleActionButtons = function(){
        this.myDebug("START toggleActionButtons selector is: " + "#" + this.classIdentifier + "-ezajaxcontent");
        var currentTabWrapper = $('#main-tabs li.ui-tabs-selected a').attr('href');
        $(currentTabWrapper + " .ezajaxcontent").find('.controls form input.button, .line-buttons form input.button').toggle();
        this.myDebug("END toggleActionButtons");
    };

    //control show/hide New Amendmends button
    rgmAjax.prototype.showAmendmend = function(){
        var avalAmendmends = $('#amendFilter option').size() -1;
        $(this.viewContentSelector + ' .line-wrapper').each(function(i, v){
            var usedAmendmends = $(this).find('.content-view-line').length -1;
            if ( avalAmendmends == usedAmendmends){
                $('.controls', this).hide();
            }
        });
    };
    rgmAjax.prototype.mceButtonsTitleOverride = function(){
        //@TODO This needs to go inside different js file
        if ( typeof(mceButtonsTitleOverride) === 'function' )
            mceButtonsTitleOverride();
    };

    rgmAjax.prototype.tabsInit = function(){
        /*$('#article_ld-view-content .line-wrapper').each(function(index, element){
            if ( $(this).find('ul').length <= 0 ){
                $(this).prepend( '<ul class="articles-nav"></ul>' );
                var counter= index + 1;
                var parent = $(this);

                $(this).find('ul').append( function(){
                    var liItem = '';
                    $.each(wrapperArray[index], function(i, e){
                        var test = $(".content-view-line:eq("+i+") h3 span", parent).text();
                        var aClass = $(".content-view-line:eq("+i+")", parent).attr('class');
                        var aClassArray = aClass.split(' ');

                        $.each(aClassArray, function(ia, el){

                            if ( el.match("^amendRelID-") ){
                                aClass = el;
                            }else{
                                aClass = '';
                            }

                        });
                        liItem += '<li class="' + this.classIdentifier + '"><a class="'+aClass+'" href="#'+wrapperArray[index][i]+'">'+test+'</a></li>';
                    });
                    return liItem;
                });
            }
        });*/




        if (this.classIdentifier === 'article_ld'){
            this.articleCreateTabs();
            this.articleAmendmendDateFilter();

            this.articleScopeFilter();
            //control show/hide New Amendmends button
            this.showAmendmend();

            //$('#main-tabs').tabs();
        }
        //xx$('#main-tabs').tabs();

    };
    rgmAjax.prototype.articleCreateTabs = function(){
        var that = this, wrapperArray = [];

        $( '#article_ld-view-content .line-wrapper').each(function(i, v){
            var obIDArray = [];
            $(this).find('.content-view-line').each(function(){
                var t = $(this);
                obIDArray.push( t.attr('id') );
            });
            wrapperArray.push( obIDArray );
        });

        $('#article_ld-view-content .line-wrapper').each(function(index, element){
            if ( $(this).find('ul').length <= 0 ){
                $(this).prepend( '<ul class="articles-nav"></ul>' );
                var counter= index + 1;
                var parent = $(this);

                $(this).find('ul').append( function(){
                    var liItem = '';
                    $.each(wrapperArray[index], function(i, e){
                        var test = $(".content-view-line:eq("+i+") h3 span", parent).text();
                        var aClass = $(".content-view-line:eq("+i+")", parent).attr('class');
                        var aClassArray = aClass.split(' ');

                        $.each(aClassArray, function(ia, el){

                            if ( el.match("^amendRelID-") ){
                                aClass = el;
                            }else{
                                aClass = '';
                            }

                        });
                        liItem += '<li class="' + that.classIdentifier + '" bla-index="'+i+'" ><a class="'+aClass+'" href="#'+wrapperArray[index][i]+'">'+test+'</a></li>';
                    });
                    return liItem;
                });
            }
        });

        //$( "#article_ld-view-content .line-wrapper" ).tabs(); //this is harcoded for article tabs because files dont have tabs
        // sorting amendments dy date
        that.sortAmendments();
        //xx$( "#article_ld-view-content .line-wrapper" ).tabs(); //this is harcoded for article tabs because files dont have tabs
    }
    rgmAjax.prototype.articleAmendmendDateFilter = function(){
        $('#amendFilter').change(function(){
            var amendFilterTempArray = [];
            $('option', this).each(function(i, e){
                amendFilterTempArray.push( $(this).val() );
                if( $(this).attr('selected') ){
                    return false;
                }
             });
            var amendFilterArray = amendFilterTempArray.reverse();

            if ( amendFilterArray.length == 1 ){
                //xx$('#article_ld-view-content .line-wrapper').tabs('select', 0);
            }else{
                $('#article_ld-view-content .line-wrapper').each(function(ind,ele){
                    var $lineObject = $(this);
                    $(amendFilterArray).each(function(i, e){
                        var _versionDetected = false;
                        $('.content-view-line', $lineObject).each(function(){
                            if( $(this).hasClass(e) ) {
                                _versionDetected = true;
                                //xx$lineObject.tabs('select', $(this).parent().find('ul li a.'+ e).parent().index() );
                                return false;
                            }
                        });
                        if (_versionDetected) return false;
                    });
                });
            }
        });
    }
    rgmAjax.prototype.articleScopeFilter = function(){
        // Defaultno stanje je dodaj na sve has-selected-scope klasu
        //$('#article_ld-view-content .line-wrapper').addClass('has-selected-scope');
        $('#article_ld-view-content .line-wrapper').removeClass('no-selected-scope');

        // 1. dio - prikupljanje informacija i kreiranje scope filtra
        var scopeFilterArray = [];
        $( "#article_ld-view-content .line-wrapper .article_ld_subject a" ).each(function(){
            var scopeName = $(this).text();
            //if( $(this).is(':visible') ){
                if($.inArray(scopeName, scopeFilterArray) === -1) scopeFilterArray.push(scopeName);
            //}
        });

        // Ispunjavanje vrijednosti u scope filteru
        $.each(scopeFilterArray, function(index, value) {
            var createValue = value.split(' ').join('-');
            $('#scopeFilter').append('<option value="'+createValue+'">'+value+'</option>');
        });

        // 2. dio - gleda promjenu scope filtra i sakriva one koji ga nemaju
        $('#scopeFilter').on('change', function(){
            var currentSelectedValue = $(this).prop('value');
            //$('#article_ld-view-content .line-wrapper').removeClass('has-selected-scope');
            $('#article_ld-view-content .line-wrapper').addClass('no-selected-scope');

            if(currentSelectedValue == 'default'){
                    $("#amendFilter option").removeAttr('disabled');
                    //if( currentSelectedValue == 'default' ) $('#article_ld-view-content .line-wrapper').addClass('has-selected-scope');
                    $('#article_ld-view-content .line-wrapper').removeClass('no-selected-scope');
                return false;
            }

            //disable amend date select
            $("#amendFilter option:not(:first)").attr('disabled', 'disabled');

            $('#article_ld-view-content .line-wrapper .article_ld_subject a').each(function(){
                //if( $(this).is(':visible') ){
                    if( $(this).text() == currentSelectedValue.split('-').join(' ') ){
                        var $closestWrapper = $(this).closest('.line-wrapper');
                        //$closestWrapper.addClass('has-selected-scope');
                        $closestWrapper.removeClass('no-selected-scope');
                        $('ul.articles-nav li a', $closestWrapper).each(function(){
                            $('#amendFilter option[value=' + $(this).attr('class') + ']').removeAttr('disabled');
                        });
                    }
                //}
            });

        });
    }
    rgmAjax.prototype.sortAmendments = function(){
        $('.line-wrapper .articles-nav').each(function(){
            var ul = $(this);
            ul.children().next().sort(function(a, b) {
                var ta = $(a).text().split("/").reverse().join();
                var tb = $(b).text().split("/").reverse().join();
                return (ta>tb) - (tb>ta);
            }).appendTo(ul);
        });
    };

    rgmAjax.prototype.iframeSetup = function(sel){
        //sel = sel || this.newContentSelector;
        if(!this.iframeSetupEnabled || !sel ){return;}
        var that = this;
        $(sel).find('iframe').load(function(e){
            var iframe_content = $(this).contents().find('html').text();
            if(iframe_content === ""){return;} //this is first on load in IE
            var $form = $(sel + " form[target^='transFrame_']");
            if( this.contentWindow.location.href.split("/").pop() === 'status' || $(this).contents().find('div.warning').length === 0 ) {

                //no validation error - file uploaded
                $(sel).empty();
                that.toggleActionButtons();
                that.getSubtree();

                //dirty hack for main tabs
                that.mainTabsInit();

            } else {
                //validation error
                var iframeHTML = $(this).contents().find("form[target^='transFrame_']").html();
                $form.html( iframeHTML );
            }

        });
    };

    rgmAjax.prototype.iframeContentCheck = function(thisObj, event){
        var frameId = event.target.id;
        var newContentDiv = event.target.parentElement.id;
        var viewContent = $('#' + event.target.parentElement.parentElement.id).find('div.ezajax-view-content').attr('id');

        if (thisObj.contentWindow.location != 'about:blank' )
        {
            if ( thisObj.contentWindow.location.href.split("/").pop(1) === 'status' )
            {
                var mainNode = $('#'+newContentDiv).find('input[name=MainNodeID]').val();
                var className = $('#'+newContentDiv).parent().find('input[name=ajaxVariableScope]').val();
                var viewContentSelector = '#'+viewContent;
                $('#'+newContentDiv).html('');

                this.toggleActionButtons();
                this.getSubtree(mainNode, className, viewContentSelector);

                //dirty hack for main tabs
                that.mainTabsInit();
            }
            else
            {
                $('#'+frameId).contents().find('input[name=PublishButton], input[name=DiscardButton]').attr( 'onclick', 'return submitChanged(this, newContentSelector);' );
                var iframeHTML = $('#'+frameId).contents().find('body').html();

                $('#'+newContentDiv).html( iframeHTML );
            }
        }
    };
    rgmAjax.prototype.mainTabsInit = function(){
        //xx$('#main-tabs').tabs();
    }
    rgmAjax.prototype.getSubtree = function(){
        var that = this;

        $.ez( 'ngajaxcrud::getSubtreeByNodeID', { ParentNode: this.MainNodeId, ClassIdentifier: this.classIdentifier }, function( data ){
            if ( data.error_text ){
                alert( data.error_text ); //put errors in formatted div
            }else{
                //this.myDebug( "Generiran response 'getSubtreeByNodeID' sa klasom "+ that.classIdentifier +" stavljam u "+that.viewContentSelector );

                $(that.viewContentSelector).html( data.content );
                $(that.viewContentSelector + ' .content-view-line:nth-child(2n-1)').addClass( 'even' );
                if($(that.viewContentSelector).hasClass('no-content')){
                    $(that.viewContentSelector).removeClass('no-content');
                }
                else if(data.content.lenght == 0){
                    $(that.viewContentSelector).addClass('no-content');
                }
                $(document).trigger("rgmSubTreeLoaded");
                that.tabsInit(that.viewContentSelector);
            }
            that.countElements();
        });
    };

    rgmAjax.prototype.myDebug = function(msg, color)
    {
        /*if ( typeof classIdentifier == 'undefined')
            var classIdentifier = false;*/
        //console.log(msg);
        return true;
        if ( this.enableMyDebug )
        {
            var backColor = '';

            if (this.classIdentifier=='article_ld'){
                backColor = 'background-color:#FFFFCC;';
            }else if(this.classIdentifier=='file'){
                backColor = 'background-color:#CCCCFF;';
            }else{
                backColor = 'background-color:#f1f1f1';
            }

            if ( typeof(color) != 'undefined' ){
                //return console.log("%c" + msg, "color:" + color + ";font-weight:bold;" + backColor);
            }

            //return console.log("%c" + msg, "font-weight:bold;" + backColor);
        }
        else
        {
            return false;
        }

    };

window.rgmAjax = rgmAjax;
})();
