{* DO NOT EDIT THIS FILE! Use an override template instead. *}
<form action={concat($module.functions.edit.uri,"/",$userID)|ezurl} method="post" name="Edit">

    <div class="maincontentheader">
        <h1>{"User profile"|i18n("dms/user/profile")}</h1>
    </div>

    <div class="form-group">
        <label for="">{"Username"|i18n("dms/user/profile")}</label>
        <div class="controls">
            {$userAccount.login|wash}
        </div>
    </div>

    <div class="form-group">
        <label for="">{"E-mail"|i18n("dms/user/profile")}</label>
        <div class="controls">
            {$userAccount.email|wash(email)}
        </div>
    </div>

    <div class="form-group">
        <label for="">{"Name"|i18n("dms/user/profile")}</label>
        <div class="controls">
            {$userAccount.contentobject.name|wash}
        </div>
    </div>

    <div class="form-group">
        <label for="">{"Signature"|i18n("dms/user/profile")}</label>
        <div class="controls">
            {attribute_view_gui attribute=$userAccount.contentobject.data_map.signature}
        </div>
    </div>

    <div class="form-group">
        <label for="">{"Image"|i18n("dms/user/profile")}</label>
        <div class="controls">
            {attribute_view_gui attribute=$userAccount.contentobject.data_map.image}
        </div>
    </div>

    <div class="buttonblock">
        <input class="text" type="hidden" name="ContentObjectLanguageCode" value="{$userAccount.contentobject.initial_language_code}" />
        <input class="button" type="submit" name="EditButton" value="{'Edit'|i18n('dms/user/profile')}" />
        <input class="button" type="submit" name="ChangePasswordButton" value="{'Change password'|i18n('dms/user/profile')}" />
    </div>

</form>
