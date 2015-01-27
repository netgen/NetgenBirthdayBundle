<div class="affix-wrapper" data-spy="affix" role="complementary" data-offset-top="70">
    <ul class="actions-nav">
        {if fetch( user, has_access_to, hash( module, tags, function, editsynonym ) )}
            <li>
                <a href="#" onclick="ezpopmenu_submitForm( 'editsynonym' ); return false;">
                    <i  class="fa fa-pencil"></i>
                    <p>{"Edit synonym"|i18n( "dms/tags" )}</p>
                </a>
                <form name="editsynonym" id="editsynonym" enctype="multipart/form-data" method="post" action={concat( 'tags/editsynonym/', $tag.id )|ezurl}>
                    <input class="defaultbutton" type="hidden" name="SubmitButton" value="{"Edit synonym"|i18n( "dms/tags" )}" />
                </form>
            </li>
        {/if}
        {if fetch( user, has_access_to, hash( module, tags, function, deletesynonym ) )}
            <li>
                <a href="#" onclick="ezpopmenu_submitForm( 'tagdelete' ); return false;">
                    <i  class="fa fa-times-circle"></i>
                    <p>{"Delete synonym"|i18n( "dms/tags" )}</p>
                </a>
                <form name="tagdelete" id="tagdelete" method="post" action={concat( 'tags/deletesynonym/', $tag.id )|ezurl}>
                    <input class="button" type="hidden" name="SubmitButton" value="{"Delete synonym"|i18n( "dms/tags" )}" />
                </form>
            </li>
        {/if}
    </ul>
</div>
