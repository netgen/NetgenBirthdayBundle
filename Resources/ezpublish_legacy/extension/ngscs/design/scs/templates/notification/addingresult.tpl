<div class="row">
    <div class="col-lg-12">
        <div class="box">
            <div class="box-header" data-original-title>
                <h2><i class="fa fa-bullhorn"></i><span class="break"></span>{"Add to my notifications"|i18n('scs/notification')}</h2>
            </div>

            <div class="box-content">

                {let node=fetch( content, node, hash( node_id, $node_id) )}
                {section show=$already_exists}
                <div class="alert alert-warning">
                    <h4 class="alert-heading">{"Warning"|i18n('scs/notification')}!</h4>
                    <p>{"Dossier <%name> already added to my notifications"|d18n('scs/notification', '', hash( '%name', $node.name|wash ))}.</p>
                </div>
                {section-else}

                <div class="alert alert-success">
                    <strong>{"Success"|i18n('scs/notification')}!</strong>
                    {"Dossier <%name> successfully added to my notifications"|d18n('scs/notification', '', hash( '%name', $node.name|wash ))}.
                </div>
                {/section}
                {/let}

                <form method="post" action={$redirect_url|ezurl}>
                    <input class="btn btn-success" type="submit" value="{'OK'|i18n('scs/notification')}" name="OK">
                     <a class="btn" href={'notification/settings'|ezurl()}>{"My notifications"|i18n('scs/notification')}</a>
                </form>
            </div>
        </div>
    </div>
</div>
