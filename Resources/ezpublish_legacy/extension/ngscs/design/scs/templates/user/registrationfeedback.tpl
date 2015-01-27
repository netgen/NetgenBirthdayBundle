<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>{'A new user has registered.'|i18n('dms/register/user')}</title>
</head>
{set-block scope=root variable=subject}{'New user registered at %siteurl'|i18n('dms/register/user',,hash('%siteurl',ezini('SiteSettings','SiteURL')))}{/set-block}<body>
<table id="container" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td id="tijelo"><h2>{'A new user has registered.'|i18n('dms/register/user')}</h2>
      <p><h3>{'Account information.'|i18n('dms/register/user')}</h3></p>
      <div>
      <p><strong>{"Username"|i18n("dms/register/user")}</strong>: <em>{$user.login}</em></p>
      <p><strong>{"Email"|i18n("dms/register/user")}</strong>: <em>{$user.email}</em></p>
      </div>
{*}
      <p>
	<a href="http://{$hostname}/administration/content/view/full/{$object.main_node_id}"> {'Link to user information'|i18n('dms/register/user')} </a>
      </p>*}
    </td>
  </tr>
</table>
</body>
</html>

{*set-block scope=root variable=subject}{'New user registered at %siteurl'|i18n('dms/register/user',,hash('%siteurl',ezini('SiteSettings','SiteURL')))}{/set-block}
{'A new user has registered.'|i18n('dms/register/user')}

{'Account information.'|i18n('dms/register/user')}
{'Username'|i18n('dms/register/user','Login name')}: {$user.login}
{'Email'|i18n('dms/register/user')}: {$user.email}

{'Link to user information'|i18n('dms/register/user')}:
http://{$hostname}{concat('content/view/full/',$object.main_node_id)|ezurl(no)}
*}
