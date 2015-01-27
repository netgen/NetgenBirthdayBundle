jQuery(function( $ )
{
    // Attache click event to search button and show input fields
    $('input.ezobject-relation-search-btn').click( _search ).removeClass('hide');

    // Attache key press event to catch enter and show input fields
    $('input.ezobject-relation-search-text').keypress( function( e ){
        if ( e.which == 13 )
        {
            return _search.call( this, e );
        }
    }).removeClass('hide');

    // Function handling search event
    function _search( e )
    {
        e.preventDefault();
        var box = $( this.parentNode.parentNode ), text = box.find('input.ezobject-relation-search-text');
        if ( text.attr('value') )
        {
            var params = { 'CallbackID': box.attr('id'), 'EncodingFetchSection': 1, 'SearchLimit': 50, 'DataMap' : ['id', 'name'] };//, 'DataMapType' : ['id', 'name']
            var node = box.find("*[name*='_for_object_start_node']"), classes = box.find("input[name*='_for_object_class_constraint_list']");
            if ( node.size() ) params['SearchSubTreeArray'] = node.attr('value');
            if ( classes.size() ) params['SearchContentClassIdentifier'] = classes.attr('value');
            $.ez( 'ezjscNgRgmServerFunctionsJs::search::' + text.attr('value'), params, _searchCallBack );
        }

        return false;
    }

    // Ajax search callback
    function _searchCallBack( data )
    {
        if ( data && data.content !== '' )
        {
            var boxID = '#' + data.content.CallbackID, boxElem = $( boxID + ' div.ezobject-relation-search-browse'  );
            if ( data.content.SearchResultCount )
            {
                boxElem.empty();
                var arr = data.content.SearchResult, pub = $('#ezobjectrelation-search-published-text');
                for ( var i = 0, l = arr.length; i < l; i++ )
                {
                    var aElem = $( '<a></a>' );
                    //Create anchorText long string
                    var IDattributeContent = typeof(arr[i].data_map.id) != 'undefined'? arr[i].data_map.id.content : '',
                        nameAttributeContent = typeof(arr[i].data_map.name) != 'undefined'? arr[i].data_map.name.content : '',
                        anchorText = (IDattributeContent.length && nameAttributeContent.length)? IDattributeContent.concat(': ').concat(nameAttributeContent) : arr[i].name;

                    aElem.bind( 'click', { boxID: boxID,
                                           id: arr[i].id,
                                           name: arr[i].name,
                                           className: arr[i].class_name,
                                           sectionName: arr[i].section.name,
                                           publishedTxt: pub.attr('value'),
                                           'anchorText': anchorText }, function(e) {
                        ezajaxrelationsSearchAddObject( this, e.data.boxID, e.data.id, e.data.anchorText, e.data.className, e.data.sectionName, e.data.publishedTxt );
                    } );

                    aElem.append( anchorText );
                    aElem.attr( 'title', aElem.text() );

                    boxElem.append( aElem );
                    //boxElem.append( '<br />' );
                }
                boxElem.show().removeClass('hide');
            }
            else
            {
                var html = '<p class="ezobjectrelation-search-empty-result">' + $('#ezobjectrelation-search-empty-result-text').html().replace( '--search-string--', '<em>' + data.content.SearchString + '<\/em>' ) + '<\/p>';
                boxElem.html( html ).show();
            }
        }
        else
        {
            alert( data.content.error_text );
        }
    }

    // function for selecting a search result object
    function _addObject( link, boxID, id, name, className, sectionName, publishedTxt )
    {
        link.onclick = function(){return false;};
        link.className = 'disabled';
        var tr = $( boxID + ' table tbody tr:last-child' ), tds = tr.find('td'), listMode = tds.size() > 4;
        if ( listMode )
        {
            if ( tds[1].innerHTML !== '--name--' )
            {
                tr = tr.clone(true).insertAfter(tr);
                tds = tr.find('td').slice( 1 );
            }
            else
            {
                tds = tds.slice( 1 );
            }
            tr[0].className = tr[0].className === 'bgdark' ? 'bglight' : 'bgdark';
            var priority = tr.find('td:last-child input');
            priority.attr( 'value', parseInt( priority.attr('value') ) + 1 );
            tr.find('td:first-child input').attr( 'value', id );
        }
        else
        {
            $( boxID + ' input[name*=_data_object_relation_id_]' ).attr( 'value', id )
        }
        tds.eq( 0 ).html( name );
        tds.eq( 1 ).html( className );
        tds.eq( 2 ).html( sectionName );
        tds.eq( 3 ).html( publishedTxt );
        $( boxID + ' table' ).removeClass('hide');
        $(boxID + ' .ezobject-relation-remove-button').removeClass('button-disabled').addClass('button btn btn-danger').attr('disabled', false);
        $(boxID + ' .ezobject-relation-remove-button').attr('style', 'display:inline;');
        $(boxID + ' .ezobject-relation-no-relation').addClass('hide');
    }

    // register searchAdd gloablly as it is used on search links
    window.ezajaxrelationsSearchAddObject = _addObject;
});
