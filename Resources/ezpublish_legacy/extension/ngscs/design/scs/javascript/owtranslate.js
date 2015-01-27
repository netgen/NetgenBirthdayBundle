$(document).ready(function() {
    $('.edit').editable('/translate/ajax_edit', {
    	onblur:	'submit',
        cssclass : 'translation_edit',
        indicator : 'Saving...',
        tooltip   : 'Click to edit...',
        event : "click",
        callback : function(value, settings, event) {
            if(value) {
            	$(this).removeClass('empty_edit');
            } else {
            	$(this).addClass('empty_edit');
            }
        }
    });

    $('.edit').on('click', function(event, $editor) {
        console.log( $(this) );
    });

    $('.click-to-open').click(function() {
        var id = $(this).attr('id');
        id = id.replace('to-', '');
        if ($('#from-'+id).hasClass('close')) {
            $('#from-'+id).show();
            $('#from-'+id).removeClass('close');
            $(this).html("Click to close");
        } else {
            $('#from-'+id).hide();
            $('#from-'+id).addClass('close');
            $(this).html("Click to open");
        }
    });
});
