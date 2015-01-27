/**
* Link whole table row or table data
* If there is just one link inside whole tr, set that link on the whole tr
* If there are more than one links inside tr, iterate through each td:
* - If td has one link inside, put an link to it
* - If td has more than one link, do nothing ( keep default behaviour )
*/
$.fn.tmTableLinks = function(opt){
  opt = opt || {};
  var that = this,
      tableBody = $(this).find("tbody").length ? true : false,
      query = tableBody ? "tbody tr" : "tr:not(:first-child)",
      rowClass = opt.rowClass || "linkable",
      preventElements = ["input", "textarea", "select", "option"];

  $(this).find(query).each(function(){
    if( $(this).find("a").length === 1 ){
      attachEventListener( $(this), "tr" );
    }else if( $(this).find("a").length > 1 ){
      $(this).find("td").each(function(){
        if( $(this).find("a").length && $(this).find("a").length === 1 ) attachEventListener( $(this), "td" );
      });
    }
  });

  function attachEventListener(el, selector){
    createStyle( el );
    el.on("click", $(selector), function(e){
      if( $.inArray( e.target.localName, preventElements ) !== -1 ){
        e.stopPropagation();
        return;
      }
      redirect( $(this) );
    });
  };

  function redirect(el){
    var href = el.find("a").attr("href");
    if( el.closest("tr").hasClass(rowClass) ){
      href = el.closest("tr").find("a").attr("href");
    }
    if( el.attr("target") == "_blank" ) {
      window.open( href, "" );
    }else{
      window.location.href = href;
    }
  };

  function createStyle(el){
    el.addClass( rowClass );
  };

};

/**
* Adding classes to list of elements. Best usage is for first/last child in the list of elements.
* If no position is specified it will return first child only.
* If any position beside first or last is passed it will be applied to all passed elements.
*/
$.fn.tmAddChildClass = function(position, className){
  position = position || 'first';
  className = className || 'tmClass';
  if( position == 'first' ){
    this.first().addClass( position+'-child' );
  }else if( position == 'last' ){
    this.last().addClass( position+'-child' );
  }else{
    this.addClass(position);
  }
};

(function(){
  var defaults = {
    actionButtons: ".actions-nav"
  },
  rgmKirgistan = {
    opt: '',
    init: function(params){
      this.opt = $.extend(defaults, params);
      rgmKirgistan.calculateNumberOfActionBtns();
      rgmKirgistan.clickableTable();
      rgmKirgistan.affix();
      rgmKirgistan.variousRules();
      rgmKirgistan.controlNext();
    },
    calculateNumberOfActionBtns: function(){
      var childrenCount = $(this.opt.actionButtons).find("li").length;
      $(this.opt.actionButtons).addClass("chl-cnt-" + childrenCount);
    },
    clickableTable: function(){
      $("table.clickable").tmTableLinks();
    },
    affix: function(){
      var that = this;
      if( $(this.opt.actionButtons).length ){
        $(this.opt.actionButtons).affix({
          offset: {
            top: $(that.opt.actionButtons).offset().top
          }
        });
      }
    },
    variousRules: function(){
      $(".navbar-nav > li").tmAddChildClass("last");
    },
    controlNext: function(){
        var that = this;
        //Control next row on click
        $('input[data-control-next], select[data-control-next]').live('click', function(){
            that.dataControlNext(this);
        });
        //Control next row on docready
        $('input[data-control-next], select[data-control-next]').each(function(){
            that.dataControlNext(this);
        });
    },
    dataControlNext: function(item){
        switch( $(item).data('control-next') )
        {
            case 'tr':
                if ($(item).is(":checked")){
                    $(item).closest('tr').next().css('background-color', '#E8E8E8').fadeIn(function(){
                        $(item).css('background-color', '');
                    });
                }else if ($(item).is('select')){
                    if ( $(item).closest('tr').next( 'tr[data-control-next-relation='+ $(item).prop('value') +']').length ){
                        $(item).closest('tr').nextAll( 'tr[data-control-next-relation='+ $(item).prop('value') +']' ).css('background-color', '#E8E8E8').fadeIn(function(){
                            $(item).css('background-color', '');
                        });
                    }else{
                        $(item).closest('tr').next().css('background-color', '#E8E8E8').fadeOut(function(){
                            $(item).css('background-color', '');
                        });
                    }
                }else{
                    $(item).closest('tr').next().css('background-color', '#E8E8E8').fadeOut(function(){
                        $(item).css('background-color', '');
                    });
                }
                break;
            case 'td':
                if ($(item).is(":checked")){
                    $(item).closest('td').nextAll().css('background-color', '#E8E8E8').fadeIn(function(){
                        $(item).css('background-color', '');
                    });
                }else if ($(item).is('select')){
                    if ( $(item).closest('td').nextAll( 'td[data-control-next-relation='+ $(item).prop('value') +']').length ){
                        $(item).closest('td').nextAll( 'td[data-control-next-relation='+ $(item).prop('value') +']' ).css('background-color', '#E8E8E8').fadeIn(function(){
                            $(item).css('background-color', '');
                        });
                    }else{
                        $(item).closest('td').nextAll().css('background-color', '#E8E8E8').fadeOut(function(){
                            $(item).css('background-color', '');
                        });
                    }
                }else{
                    $(item).closest('td').nextAll().css('background-color', '#E8E8E8').fadeOut(function(){
                        $(item).css('background-color', '');
                    });
                }
                break;
            default:
                if (typeof console != "undefined" )
                    console.log("Undefined value data-control-next ! ! !");
        }
    }
  };

  window.rgmKirgistan = rgmKirgistan;

})();

$(function(){
  rgmKirgistan.init();

  var $affix = $(".actions-nav"),
  $parent = $affix.parent(),
  resize = function() { $affix.width($parent.width()); };
  $(window).resize(resize);
  resize();

});
