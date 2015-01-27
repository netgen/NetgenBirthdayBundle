<form enctype="multipart/form-data" id="edit-content" method="post" action={concat("/content/edit/",$object.id,"/",$edit_version,"/",$edit_language|not|choose(concat($edit_language,"/"),''))|ezurl}>
    <div class="form-actions hide">
        <input type="submit" name="PublishButton"  />
        <input type="submit" name="StoreButton"  />
        <input  type="submit" name="DiscardButton"  />
        <input type="submit" name="PreviewButton"  />
        <input type="submit" name="VersionsButton"/>
        <input type="hidden" name="DiscardConfirm" value="0" />
        {if $edit_version|gt(1)}
            <input type="hidden" name="RedirectURIAfterPublish" value="/" />
            <input type="hidden" name="RedirectIfDiscarded" value="/" />
        {/if}
    </div>

    <div class="row">
        <div class="col-lg-11 col-sm-10">
            <div class="box">
                <div class="box-header" data-original-title>
                    <h2>{if $edit_version|eq(1)}{"New"|i18n( 'dms/edit/user' )} {"User"|i18n( 'dms/edit/user' )}{else}{"Edit"|i18n( 'dms/edit/user' )} {"User"|i18n( 'dms/edit/user' )}{/if}</h2>
                </div>
                <div class="box-content">

                    {include uri="design:content/edit_validation.tpl"}

                    {include uri="design:content/edit_attribute.tpl"}
                </div>

            </div>
        </div>

        <div class="col-lg-1 col-sm-2">
                <ul class="actions-nav">
                    <li>
                        <a href="#" onclick="ezpopmenu_submitForm( 'edit-content', null, 'PublishButton' ); return false;">
                            <i class="fa fa-check"></i>
                            <p>{"Save"|i18n( 'design/standard/content/edit' )}</p>
                        </a>
                        <a href="#" onclick="ezpopmenu_submitForm( 'edit-content', null, 'DiscardButton' ); return false;">
                            <i class="fa fa-times"></i>
                            <p>{"Discard"|i18n( 'design/standard/content/edit' )}</p>
                        </a>
                    </li>
                </ul>
        </div>
    </div>

</form>
