<div class="row">
    <div class="col-lg-12 col-sm-12">
        <div class="register-box">

            <h1>{"Sign up"|i18n("dms/register/user")}</h1>

            <hr>

            <div class="box-content">
                <form enctype="multipart/form-data"	action={"/user/register/"|ezurl} method="post" name="Register" id="register">
                    <div class="hide">
                        <input type="submit" name="PublishButton" value="{"Save"|i18n( 'dms/edit/user' )}" />
                        <input type="submit" name="DiscardButton" value="{"Cancel"|i18n( 'dms/edit/user' )}" />
                        <input type="hidden" name="UserID" value="{$content_attributes[0].contentobject_id}" />
                    </div>

                    {if and( and( is_set( $checkErrNodeId ), $checkErrNodeId ), eq( $checkErrNodeId, true() ) )}
                        <div class="alert alert-danger">
                            <h2><span class="time">[{currentdate()|l10n( shortdatetime )}]</span> {$errMsg}</h2>
                        </div>
                    {/if}

                    {if $validation.processed}
                        {if $validation.attributes|count|gt(0)}
                            <div class="alert alert-danger">
                                <p><strong>{"Input did not validate"|i18n("dms/register/user")}</strong></p>
                                <ul>
                                    {foreach $validation.attributes as $attribute}
                                        <li>{$attribute.name|d18n("dms/register/user")}` {$attribute.description|d18n("dms/register/user")}</li>
                                    {/foreach}
                                </ul>
                            </div>
                                {else}
                            <div class="alert alert-success">
                                <p><strong>{"Input was stored successfully"|i18n("dms/register/user")}</strong></p>
                            </div>
                        {/if}
                    {/if}

                    <div class="row">
                        {if count($content_attributes)|gt(0)}
                            <div class="col-lg-6">
                                <h2>{"User info"|i18n("dms/register/user")}</h2>
                                <div class="form-group">
                                    <label>{$content_attributes.0.contentclass_attribute.name|d18n("dms/register/user")}</label>
                                    {attribute_edit_gui attribute=$content_attributes.0}
                                </div>

                                <div class="form-group">
                                    <label>{$content_attributes.1.contentclass_attribute.name|d18n("dms/register/user")}</label>
                                    {attribute_edit_gui attribute=$content_attributes.1}
                                </div>

                                <div class="form-group">
                                    <label>{$content_attributes.3.contentclass_attribute.name|d18n("dms/register/user")}</label>
                                    {attribute_edit_gui attribute=$content_attributes.3 register}
                                </div>

                                <div class="form-group">
                                    <label>{$content_attributes.4.contentclass_attribute.name|d18n("dms/register/user")}</label>
                                    {attribute_edit_gui attribute=$content_attributes.4}
                                </div>

                                <div class="form-group">
                                    <label>{$content_attributes.5.contentclass_attribute.name|d18n("dms/register/user")}</label>
                                    {attribute_edit_gui attribute=$content_attributes.5}
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <h2>{$content_attributes.2.contentclass_attribute.name|d18n("dms/register/user")}</h2>
                                    {attribute_edit_gui attribute=$content_attributes.2}
                                </div>
                            </div>
                        {else}
                            <div class="alert alert-danger">
                                <h2>{"Error"|i18n("dms/register/user")}</h2>
                            </div>
                            <input class="button" type="submit" name="CancelButton" value="{'Back'|i18n('dms/register/user')}" />
                        {/if}
                    </div>

                    {*if count($content_attributes)|gt(0)}
                            {foreach $content_attributes as $attribute}
                                <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
                                <div class="block">
                                    <label>{$attribute.contentclass_attribute.name|d18n("dms/register/user")}</label>
                                    <div class="labelbreak"></div>
                                    {attribute_edit_gui attribute=$attribute}
                                </div>
                            {/foreach}
                    {else}
                            <div class="alert alert-danger">
                                <h2>{"Error"|i18n("dms/register/user")}</h2>
                            </div>
                            <input class="button" type="submit" name="CancelButton" value="{'Back'|i18n('dms/register/user')}" />
                    {/if*}
                    <hr>
                    <input type="submit" value="{'Sign up'|i18n('dms/register/user')}" name="PublishButton" id="PublishButton" class="btn btn-success">
                </form>
            </div>
        </div>
    </div>
</div>
