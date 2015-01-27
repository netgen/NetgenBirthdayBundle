<div class="row">
    <div class="login-box">

        {if $link}
        <p>
        {"An email has been sent to the following address: %1. It contains a link you need to click so that we can confirm that the correct user has received the new password."|i18n('eregistry/password/user',,array($email))}
        </p>
        {else}
           {if $wrong_email}
           <div class="warning">
           <h2>{"There is no registered user with that email address."|i18n('eregistry/password/user')}</h2>
           </div>
           {/if}
           {if $generated}
           <p>
           {"Password was successfully generated and sent to: %1"|i18n('eregistry/password/user',,array($email))}
           </p>
           {else}
              {if $wrong_key}
              <div class="warning">
              <h2>{"The key is invalid or has been used."|i18n('eregistry/password/user')}</h2>
              </div>
              {else}
              <form method="post" name="forgotpassword" action={"/user/forgotpassword/"|ezurl}>

              <h2>{"Have you forgotten your password?"|i18n('eregistry/password/user')}</h2>

              <hr/>
              <p>
              {"If you have forgotten your password, enter your email address and we will create a new password and send it to you."|i18n('eregistry/password/user')}
              </p>

              <label for="email">{"Email"|i18n('eregistry/password/user')}</label>
              <input class="input-large col-xs-12" type="text" name="UserEmail" size="40" value="{$wrong_email|wash}" />
              <button type="submit" class="btn btn-primary col-xs-12" name="GenerateButton">{'Generate new password'|i18n('eregistry/password/user')}</button>

              </form>

              {/if}
           {/if}
        {/if}
    </div>
</div><!--/row-->