<div class="row">
    <div class="login-box">
        <h2>{"Change password for user"|i18n("dms/user/password")} {$userAccount.login}</h2>
        <hr/>
        <form class="form-horizontal" action={concat($module.functions.password.uri,"/",$userID)|ezurl} method="post" name="Password">

        <label for="oldpassword">{if $oldPasswordNotValid}*{/if}{"Old password"|i18n("dms/user/password")}</label>
        <input class="input-large col-xs-12" name="oldPassword" id="oldpassword" type="password" tabindex="1" value="{$oldPassword}"/>

        <label for="newpassword">{if $newPasswordNotMatch}*{/if}{"New password"|i18n("dms/user/password")}</label>
        <input class="input-large col-xs-12" name="newPassword" id="newpassword" type="password" tabindex="1" value="{$newPassword}"/>

        <label for="confirmpassword">{if $newPasswordNotMatch}*{/if}{"Retype password"|i18n("dms/user/password")}</label>
        <input class="input-large col-xs-12" name="confirmPassword" id="confirmpassword" type="password" tabindex="1" value="{$confirmPassword}"/>

        <div class="clearfix"></div>

        <button type="submit" class="btn btn-primary col-xs-12">{'Ok'|i18n('dms/user/login','Button')}</button>

        {if $message}
            {if or($oldPasswordNotValid,$newPasswordNotMatch)}
                {if $oldPasswordNotValid}
                    <div class="warning">
                        <h2>{'Please retype your old password.'|i18n('dms/user/password')}</h2>
                    </div>
                {/if}
                {if $newPasswordNotMatch}
                    <div class="warning">
                        <h2>{"Password didn't match, please retype your new password."|i18n('dms/user/password')}</h2>
                    </div>
                {/if}

            {else}
                <div class="feedback">
                    <h2>{'Password successfully updated.'|i18n('dms/user/password')}</h2>
                </div>
            {/if}

        {/if}
        </form>
    </div>
</div><!--/row-->