<div class="row">
    <div class="login-box">
        <h2>{'Login'|i18n('dms/user/login')}</h2>
        <hr/>
        <form class="form-horizontal" action="{"/user/login/"|ezurl}" method="post">
            <fieldset>

                <input class="input-large col-xs-12" name="Login" id="username" type="text" placeholder="type username" value="{$User:login|wash}" tabindex="1" />

                <input class="input-large col-xs-12" name="Password" id="password" type="password" placeholder="type password" tabindex="1"/>

                {if $User:warning.bad_login}
                    <div class="alert alert-danger">
                        <p><strong>{"Could not login"|i18n("dms/user/login")}</strong></p>
                        <ul>
                            <li>{"A valid username and password is required to login."|i18n("dms/user/login")}</li>
                        </ul>
                    </div>
                {elseif $site_access.allowed|not}
                    <div class="alert alert-danger">
                        <p><strong>{"Access not allowed"|i18n("dms/user/login")}</strong></p>
                        <ul>
                            <li>{"You are not allowed to access %1."|i18n("dms/user/login",,array($site_access.name))}</li>
                        </ul>
                    </div>
                {/if}

                <div class="clearfix"></div>

                <button type="submit" class="btn btn-primary col-xs-12">{'Login'|i18n('dms/user/login','Button')}</button>
            </fieldset>

            <input type="hidden" name="RedirectURI" value="{$User:redirect_uri|wash}" />
            {section show=and( is_set( $User:post_data ), is_array( $User:post_data ) )}
                {section name=postData loop=$User:post_data }
                    <input name="Last_{$postData:key}" value="{$postData:item}" type="hidden" /><br/>
                {/section}
            {/section}
        </form>
        <hr/>
        <h3>Forgot Password?</h3>
        <p>
            No problem, <a href={"/user/forgotpassword"|ezurl}>click here</a> to get a new password.
        </p>
        <hr/>
        <h3>Don't have an account?</h3>
        <p>
            Please, <a href={"user/register"|ezurl}>click here</a> to sign up.
    </div>
</div><!--/row-->
