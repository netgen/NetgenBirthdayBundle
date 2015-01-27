<div class="affix-wrapper" data-spy="affix" role="complementary" data-offset-top="70">
    <ul class="actions-nav">

        {if $tag.parent_id|ne(0)}
            {if fetch( user, has_access_to, hash( module, tags, function, edit ) )}
                <li>
                    <a href="#" onclick="ezpopmenu_submitForm( 'tagedit' ); return false;">
                        <i  class="fa fa-pencil"></i>
                        <p>{"Edit tag"|i18n( "dms/tags" )}</p>
                    </a>
                    <form name="tagedit" id="tagedit" enctype="multipart/form-data" method="post" action={concat( 'tags/edit/', $tag.id )|ezurl}>
                        <input class="button" type="hidden" name="SubmitButton" value="{"Edit tag"|i18n( "dms/tags" )}" />
                    </form>
                </li>
            {/if}
            {if fetch( user, has_access_to, hash( module, tags, function, delete ) )}
                <li>
                    <a href="#" onclick="ezpopmenu_submitForm( 'tagdelete' ); return false;">
                        <i  class="fa fa-times"></i>
                        <p>{"Delete tag"|i18n( "dms/tags" )}</p>
                    </a>
                    <form name="tagdelete" id="tagdelete" enctype="multipart/form-data" method="post" action={concat( 'tags/delete/', $tag.id )|ezurl}>
                        <input class="button" type="hidden" name="SubmitButton" value="{"Delete tag"|i18n( "dms/tags" )}" />
                    </form>
                </li>
            {/if}
            {if fetch( user, has_access_to, hash( module, tags, function, merge ) )}
                <li>
                    <a href="#" onclick="ezpopmenu_submitForm( 'tagmerge' ); return false;">
                        <i  class="fa fa-link"></i>
                        <p>{"Merge tag"|i18n( "dms/tags" )}</p>
                    </a>
                    <form name="tagmerge" id="tagmerge" enctype="multipart/form-data" method="post" action={concat( 'tags/merge/', $tag.id )|ezurl}>
                        <input class="button" type="hidden" name="SubmitButton" value="{"Merge tag"|i18n( "dms/tags" )}" />
                    </form>
                </li>
            {/if}
        {/if}
        {if fetch( user, has_access_to, hash( module, tags, function, addsynonym ) )}
            <li>
                <a href="#" onclick="ezpopmenu_submitForm( 'tagaddsynonym' ); return false;">
                    <i  class="fa fa-pencil-square-o"></i>
                    <p>{"Add synonym"|i18n( "dms/tags" )}</p>
                </a>
                <form name="tagaddsynonym" id="tagaddsynonym" enctype="multipart/form-data" method="post" action={concat( 'tags/addsynonym/', $tag.id )|ezurl}>
                    <input class="button" type="hidden" name="SubmitButton" value="{"Add synonym"|i18n( "dms/tags" )}" />
                </form>
            </li>
        {/if}
        {if $tag.parent_id|ne(0)}
            {if fetch( user, has_access_to, hash( module, tags, function, makesynonym ) )}
                <li>
                    <a href="#" onclick="ezpopmenu_submitForm( 'tagmakesynonym' ); return false;">
                        <i  class="fa fa-retweet"></i>
                        <p>{"Convert to synonym"|i18n( "dms/tags" )}</p>
                    </a>
                    <form name="tagmakesynonym" id="tagmakesynonym" enctype="multipart/form-data" method="post" action={concat( 'tags/makesynonym/', $tag.id )|ezurl}>
                        <input class="button" type="hidden" name="SubmitButton" value="{"Convert to synonym"|i18n( "dms/tags" )}" />
                    </form>
                </li>
            {/if}
            <li>
                <a href={$tag.parent.url|ezurl}>
                    <i  class="fa fa-arrow-circle-up"></i>
                    <p>{"Go to the parent tag"|i18n( "dms/tags" )}</p>
                </a>
            </li>
        {else}
            <li>
                <a href={'tags/dashboard'|ezurl}>
                    <i  class="fa fa-arrow-circle-up"></i>
                    <p>{"Go to the parent tag"|i18n( "dms/tags" )}</p>
                </a>
            </li>
        {/if}
    </ul>
</div>
