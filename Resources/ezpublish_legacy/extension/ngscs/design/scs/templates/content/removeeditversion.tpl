<div class="row">

        {let version=fetch( content, version, hash( object_id, $object_id, version_id, $object_version ) )}
        <form action={"content/removeeditversion"|ezurl} method="post" name="EditVersionRemove">

        <div class="alert alert-warning">
            <h4 class="alert-heading">Warning!</h4>
            <p>{"Are you sure you want to discard the draft %versionname?"
                |i18n( 'design/standard/content/edit',,
                hash( '%versionname', concat( '<i>', $version.version_name|wash, '</i>' ) ) )}</p>
        </div>

        <div class="form-actions">
            <button class="btn btn-primary" type="submit" name="ConfirmButton">{'Confirm'|i18n('design/standard/content/edit')}</button>
            <button class="btn" type="submit" name="CancelButton">{'Cancel'|i18n('design/standard/content/edit')}</button>

        </div>

        </form>

    {/let}

</div>