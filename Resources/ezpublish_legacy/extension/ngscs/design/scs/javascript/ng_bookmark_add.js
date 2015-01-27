jQuery(function($){
    var ngUrlGenerateResult;

    $('#bookmarksearch-open').click(function() {
        $('#bookmarksearch').removeClass().addClass('bookmarksearch-active');
    });

    $('#bookmarksearch-add').click(function() {
        var ngUrlGenerateResult = ngUrlGenerate();
        $.ez( 'ezjscNgBookmark::addObjects',
        {
            nodeName: $('#nodename').val(),
            nodeID: ngUrlGenerateResult[0],
            ng_title: $('#bookmarksearch-title').val(),
            ng_url: ngUrlGenerateResult[1]
        }, function(data) {console.log("test");
            $('#bookmarksearch-links').empty();
            for (var i in data.content.bookmarks) {console.log( data.content.bookmarks[i] );
                $('#bookmarksearch-links').append('<li><a href="' + $('[name="ngbm-urlbase"]').val() + decodeURIComponent(data.content.bookmarks[i].url) + '">' + decodeURIComponent(data.content.bookmarks[i].title) + '</a></li>');
            }
        });
    });
});

function ngUrlGenerate() {
    var generated_url = '/(show)/search';
    var defaultsearchnode = $('input[name=ngbm-searchnode]').val();
    var parentnode = '';

    $('#sForm').find('input:not([type="hidden"], [type="button"], [type="submit"], [type="reset"]), select').each(function(){
        if ($(this).val()) {
            generated_url = generated_url + '/(' + $(this).attr( 'name' ) + ')' + '/' + $(this).val();
        }
    });

    return [defaultsearchnode, generated_url];
}
