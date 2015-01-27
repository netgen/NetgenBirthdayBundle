<div class="box">
    <div class="box-header">
        <h2><i class="fa fa-pencil-square-o"></i>{"Delete synonym"|i18n( 'dms/tags' )}: {$tag.keyword|wash} [{$tag.id}]</h2>
        <div class="box-icon">
            <a class="btn-minimize" href="/Users#"><i class="fa fa-chevron-up"></i></a>
        </div>
    </div>
    <div class="box-content">
        <h3>{'Are you sure you want to delete the "%keyword" synonym?'|i18n( 'dms/tags', , hash( '%keyword', $tag.keyword|wash ) )}</h3>
        <form name="tagdeleteform" id="tagdeleteform" enctype="multipart/form-data" method="post" action={concat( 'tags/deletesynonym/', $tag.id )|ezurl}>
            <div class="form-group">
                 <div class="controls row">
                    <div class="input-group col-sm-4">
                        <p><label for="TransferObjectsToMainTag"><input type="checkbox" id="TransferObjectsToMainTag" name="TransferObjectsToMainTag" checked="checked" /> {'Transfer all related objects to the main tag'|i18n( 'dms/tags' )}</label></p>

                        <div class="form-actions">
                            <input class="btn btn-danger" type="submit" name="YesButton" value="{'Yes'|i18n( 'dms/tags' )}" />
                            <input class="btn" type="submit" name="NoButton" value="{'No'|i18n( 'dms/tags' )}" />
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>


