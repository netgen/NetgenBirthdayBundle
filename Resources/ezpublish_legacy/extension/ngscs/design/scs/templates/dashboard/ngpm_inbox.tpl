{*cache-block keys=array( $user.contentobject_id )*}
{def $strong_start = ''}
{def $strong_end = ''}
{def $inbox = fetch( 'ngpm', 'inbox', hash( 'limit', $block.number_of_items ) )}

<h2><a href={"ngpm/inbox"|ezurl}>{'My latest messages'|i18n( 'dms/dashboard' )}</a></h2>
{if $inbox}

<table class="list" cellpadding="0" cellspacing="0" border="0" width="100%">
    <thead>
		<tr>
	        <th>{'From'|i18n( 'dms/dashboard' )}</th>
	        <th>{'Subject'|i18n( 'dms/dashboard' )}</th>
	        <th>{'Date'|i18n( 'dms/dashboard' )}</th>
	        <th class="tight">&nbsp;</th>
	    </tr>
    </thead>
    <tbody>

    {foreach $inbox as $message sequence array( 'bglight', 'bgdark' ) as $style}
        {if $message.read_state|eq(0)}
          {set $strong_start = '<strong>'}
          {set $strong_end = '</strong>'}
        {/if}
        <tr class="{$style}">
            <td>{$strong_start}
                {fetch('content','object',hash('object_id',$message.sender)).name|wash()}
                {$strong_end}
            </td>
            <td>{$strong_start}
                {$message.pm_subject|wash()}
                {$strong_end}
            </td>
            <td>{$strong_start}
                {$message.send_date|l10n('shortdatetime')}
                {$strong_end}
            </td>
            <td>
               <a href={concat("/ngpm/view/", $message.msg_id)|ezurl()}><img src={"show.png"|ezimage} title="{"Show"|i18n('dms/dashboard')}" alt="{"Show"|i18n('dms/dashboard')}" /></a>
               {if fetch('content','object',hash('object_id',$message.sender)).id|ne(14)}<a href={concat("/ngpm/reply/", $message.msg_id)|ezurl()}><img src={"reply.png"|ezimage} title="{"Reply"|i18n('dms/dashboard')}" alt="{"Reply"|i18n('dms/dashboard')}" /></a>{/if}
            </td>
        </tr>
        {set  $strong_start = ''
              $strong_end = ''}
    {/foreach}
    </tbody>
</table>

{else}

<p>{'Your inbox list is empty.'|i18n( 'dms/dashboard' )}</p>

{/if}

{undef $inbox $strong_start $strong_end}

{*/cache-block*}
