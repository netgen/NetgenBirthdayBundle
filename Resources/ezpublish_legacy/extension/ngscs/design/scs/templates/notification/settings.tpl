{def $handlers=fetch('notification','handler_list')}

<div class="row">
    <div class="col-lg-12">

        {foreach $handlers as $handler}
            {if and($handler.id_string|eq("ezsubtree"), $handler.rules|count)}
                <form method="post" action={"/notification/settings/"|ezurl}>
                {include handler=$handler uri=concat( "design:notification/handler/",$handler.id_string,"/settings/edit.tpl")}
                </form>
            {/if}
        {/foreach}

        <div class="box">
            <div class="box-header" data-original-title>
                <h2><i class="fa fa-bullhorn"></i><span class="break"></span>{"Notification settings"|i18n('scs/notification')}</h2>
            </div>

            <div class="box-content">

                <form method="post" action={"/notification/settings/"|ezurl}>

                    {foreach $handlers as $handler}
                        {if $handler.id_string|ne("ezsubtree")}
                        {include handler=$handler uri=concat( "design:notification/handler/",$handler.id_string,"/settings/edit.tpl")}
                        {delimiter}<br/>{/delimiter}
                        {/if}
                    {/foreach}

                <input class="btn btn-success" type="submit" name="Store" value="{'Apply'|i18n('scs/notification')}" />
                </form>
            </div>
        </div>

        {undef $handlers}
    </div>
</div>
