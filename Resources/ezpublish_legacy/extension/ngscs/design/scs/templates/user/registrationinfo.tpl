<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
{let site_url=ezini('SiteSettings','SiteURL')}
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>{'Thank you for registering at %siteurl.'|i18n('dms/register/user',,hash('%siteurl',$site_url))}</title>
</head>
{set-block scope=root variable=subject}{'%1 registration info'|i18n('dms/register/user',,array($site_url))}{/set-block}
<body>
<table id="container" border="0" cellspacing="0" cellpadding="0">
  <tr>
    {def $user_object = fetch('content', 'object', hash( 'object_id', $user.contentobject_id ))}
    <td id="tijelo"><h1>{'Dear %name'|i18n( 'dms/register/user',, hash( '%name', concat( $user_object.data_map.first_name, ' ', $user_object.data_map.last_name )  ) )},</h1>
    <h2>{'Thank you for registering at %siteurl.'|i18n('dms/register/user',,hash('%siteurl',$site_url))} </h2>
    {section show=and( is_set( $hash ), $hash )}
      <p>
   {'Click the following URL to confirm your account (%link).'|i18n('dms/register/user',, hash( '%link', concat('<a href="http://', $hostname, '/user/activate/', $hash, '/', $object.main_node_id, '">http://', $hostname, '/user/activate/', $hash, '/', $object.main_node_id, '</a>') ))}
   {'If not an active link, please go to %link.'|i18n('dms/register/user',, hash( '%link', concat('<a href="http://', $hostname, '/user/activate/', $hash, '/', $object.main_node_id, '">http://', $hostname, '/user/activate/', $hash, '/', $object.main_node_id, '</a>') ))}
      </p>
      {/section}
      <p><h3>{'Your account information'|i18n('dms/register/user')} </h3></p>
      <div>
      <p><strong>{"Username:"|i18n("dms/register/user")}</strong> <em>{$user.login}</em></p>
      <p><strong>{"Email:"|i18n("dms/register/user")}</strong> <em>{$user.email}</em></p>
      {section show=$password}
      <p><strong>{"Password:"|i18n("dms/register/user")}</strong> {$password}</p>
      {/section}

      <p>{"Sincerely,"|i18n("dms/register/user")}</p>
      <p>{"National Centre for Legislative Regulations"|i18n("dms/register/user")}</p>
      </div>
    </td>
  </tr>
</table>
</body>
{/let}
</html>
