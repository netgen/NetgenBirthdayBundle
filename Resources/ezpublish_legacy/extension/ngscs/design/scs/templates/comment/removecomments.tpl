<div class="box">
    <div class="box-header">
        <h2><i class="fa fa-user"></i><span class="break"></span>{'Confirm comments removal'|i18n( 'ezcomments/comment/removecomments' )}</h2>
        <div class="box-icon">
            <a class="btn-minimize" href="/Users/Members#"><i class="fa fa-chevron-up"></i></a>
        </div>
    </div>

    <div class="box-content">

        <div class="alert alert-warning">
            <button data-dismiss="alert" class="close" type="button">×</button>
            <h4 class="alert-heading">{"Warning!"|i18n("scs/comments")}</h4>
            <p>{'Are you sure you want to remove selected comments?'|i18n( 'ezcomments/comment/removecomments' )}</p>
        </div>

        <div class="controls">
            <form action={'comment/removecomments'|ezurl} method="post" name="CommentRemove">
                <input class="btn btn-danger" type="submit" name="ConfirmButton" value="{'OK'|i18n( 'ezcomments/comment/removecomments' )}" />
                <input class="btn btn-warning" type="submit" name="CancelButton" value="{'Cancel'|i18n( 'ezcomments/comment/removecomments' )}" />
            </form>
        </div>
    </div>
</div>
