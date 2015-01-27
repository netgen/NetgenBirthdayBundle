
{default attribute_base=ContentObjectAttribute}

{if $attribute.version|eq(1)}

    {if ne( $attribute_base, 'ContentObjectAttribute' )}
        {def $id_base = concat( 'ezcoa-', $attribute_base, '-', $attribute.contentclassattribute_id, '_', $attribute.contentclass_attribute_identifier )}
    {else}
        {def $id_base = concat( 'ezcoa-', $attribute.contentclassattribute_id, '_', $attribute.contentclass_attribute_identifier )}
    {/if}
{/if}

{* Username. *}
<div class="element"{if $attribute.version|ne(1)} style="display:none;"{/if}>
    <label for="{$id_base}_login">{'Username'|i18n( 'dms/edit/user' )}</label>
    {if $attribute.content.has_stored_login}
        <input class="form-control" id="{$id_base}_login" type="text" name="{$attribute_base}_data_user_login_{$attribute.id}_stored_login" size="16" value="{$attribute.content.login}" disabled="disabled" />
        <input id="{$id_base}_login_hidden" type="hidden" name="{$attribute_base}_data_user_login_{$attribute.id}" value="{$attribute.content.login}" />
    {else}
        <input id="{$id_base}_login" autocomplete="off" class="form-control ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" name="{$attribute_base}_data_user_login_{$attribute.id}" size="16" value="{$attribute.content.login}" />
    {/if}
</div>

{* Password #1. *}
<div class="element"{if $attribute.version|ne(1)} style="display:none;"{/if}>
    <label for="{$id_base}_password">{'Password'|i18n( 'dms/edit/user' )}</label>
    <input id="{$id_base}_password" class="form-control ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="password" name="{$attribute_base}_data_user_password_{$attribute.id}" size="16" value="{if $attribute.content.original_password}{$attribute.content.original_password}{else}{if $attribute.content.has_stored_login}_ezpassword{/if}{/if}" />
</div>

{* Password #2. *}
<div class="element"{if $attribute.version|ne(1)} style="display:none;"{/if}>
    <label for="{$id_base}_password_confirm">{'Confirm password'|i18n( 'dms/edit/user' )}</label>
    <input id="{$id_base}_password_confirm" class="form-control ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="password" name="{$attribute_base}_data_user_password_confirm_{$attribute.id}" size="16" value="{if $attribute.content.original_password_confirm}{$attribute.content.original_password_confirm}{else}{if $attribute.content.has_stored_login}_ezpassword{/if}{/if}" />
</div>

{* Email. *}
    <label for="{$id_base}_email">{'Email'|i18n( 'dms/edit/user' )}</label>
    <input id="{$id_base}_email" class="form-control ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" name="{$attribute_base}_data_user_email_{$attribute.id}" size="28" value="{$attribute.content.email|wash( xhtml )}" />

{* Email #2. Require e-mail confirmation *}
{if ezini( 'UserSettings', 'RequireConfirmEmail' )|eq( 'true' )}
    <label for="{$id_base}_email_confirm">{'Confirm email'|i18n( 'dms/edit/user' )}:</label>
    <input id="{$id_base}_email_confirm" class="form-control ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" name="{$attribute_base}_data_user_email_confirm_{$attribute.id}" size="28" value="{cond( ezhttp_hasvariable( concat( $attribute_base, '_data_user_email_confirm_', $attribute.id ), 'post' ), ezhttp( concat( $attribute_base, '_data_user_email_confirm_', $attribute.id ), 'post')|wash( xhtml ), $attribute.content.email )}" />
{/if}


{/default}
