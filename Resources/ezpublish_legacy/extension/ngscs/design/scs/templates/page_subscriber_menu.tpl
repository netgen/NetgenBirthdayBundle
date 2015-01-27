{def $subscriptions=fetch( 'notification', 'subscribed_nodes' )}

{def $is_subscribed=false()}
{foreach $subscriptions as $subscription}
	{if $subscription.node.node_id|eq($node.node_id)}{set $is_subscribed=true()}{/if}
{/foreach}

<a onclick="ezpopmenu_submitForm( 'notify' ); return false;" href="#"{if $is_subscribed} class="disabled"{/if}>
    <i class="fa fa-bell"></i>
    <p>{'Notify me about updates'|i18n('scs/notification')}</p>
</a>
<form method="post" action={"/content/action"|ezurl} id="notify">
    <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
    <input type="hidden" name="ActionAddToNotification" value="" />
</form>
