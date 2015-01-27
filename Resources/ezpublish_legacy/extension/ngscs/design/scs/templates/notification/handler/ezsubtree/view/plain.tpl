{let use_url_translation=ezini('URLTransator','Translation')|eq('enabled')
     is_update=false()}
{section loop=$object.versions}{section show=and($:item.status|eq(3),$:item.version|ne($object.current_version))}{set is_update=true()}{/section}{/section}

{def $page_subscriber_classes = ezini('DMSSettings', 'NotificationClasses', 'dms.ini')}

{if $page_subscriber_classes|contains(object.class_identifier)}
	{def $dossier=$object}
{elseif $page_subscriber_classes|contains($object.main_node.parent.object.class_identifier)}
	{def $dossier=$object.main_node.parent.object}
{elseif $page_subscriber_classes|contains($object.main_node.parent.parent.object.class_identifier)}
	{def $dossier=$object.main_node.parent.parent.object}
{/if}

{section show=$is_update}
{set-block scope=root variable=subject}{'"%name" was updated'|i18n('dms/notification/plain', '', hash( '%name', $dossier.name|wash ))}{/set-block}
{set-block scope=root variable=from}{$sender}{/set-block}
{set-block scope=root variable=message_id}{concat('<node.',$object.main_node_id,'.eznotification','@',ezini("SiteSettings","SiteURL"),'>')}{/set-block}
{set-block scope=root variable=reply_to}{$sender}{/set-block}
{set-block scope=root variable=references}{section name=Parent loop=$object.main_node.path_array}{concat('<node.',$:item,'.eznotification','@',ezini("SiteSettings","SiteURL"),'>')}{delimiter}{" "}{/delimiter}{/section}{/set-block}
{set-block variable=$pre_text}
{"This e-mail is to inform you that an updated item has been published at %sitename."|i18n('dms/notification/plain','',hash('%sitename',ezini("SiteSettings","SiteURL")))}
{"The item can be viewed by using the URL below."|i18n('dms/notification/plain')}

{$object.name|wash} - {$object.current.creator.name|wash} (Owner: {$object.owner.name|wash})
{/set-block}
{section-else}
{set-block scope=root variable=subject}{'"%name" was published'|i18n('dms/notification/plain', '', hash( '%name', $dossier.name|wash ))}{/set-block}
{set-block scope=root variable=from}{$sender}{/set-block}
{set-block scope=root variable=message_id}{concat('<node.',$object.main_node_id,'.eznotification','@',ezini("SiteSettings","SiteURL"),'>')}{/set-block}
{set-block scope=root variable=reply_to}{$sender}{/set-block}
{set-block scope=root variable=references}{section name=Parent loop=$object.main_node.parent.path_array}{concat('<node.',$:item,'.eznotification','@',ezini("SiteSettings","SiteURL"),'>')}{delimiter}{" "}{/delimiter}{/section}{/set-block}
{set-block variable=$pre_text}
{"This e-mail is to inform you that a new item has been published at %sitename."|i18n('dms/notification/plain','',hash('%sitename',ezini("SiteSettings","SiteURL")))}
{"The item can be viewed by using the URL below."|i18n('dms/notification/plain')}

{$dossier.name}
{$dossier.modified|l10n(date)}
{$object.name|wash} - {$object.owner.name|wash}
{/set-block}
{/section}

{set-block variable=$html_content}
{$pre_text}
{*section name=Parent loop=$object.main_node.parent.path_array}{concat('<node.',$:item,'.eznotification','@',ezini("SiteSettings","SiteURL"),'>')}{delimiter}{" "}{/delimiter}{/section*}
{$object.content_class.name|wash}

http://{ezini("SiteSettings","SiteURL")}{cond( $use_url_translation, $object.main_node.url_alias|ezurl(no),
                                               true(), concat( "/content/view/full/", $object.main_node_id )|ezurl(no) )}


http://{ezini("SiteSettings","SiteURL")}{concat("notification/settings/")|ezurl(no)}

--
{"%sitename notification system"
 |i18n('dms/notification/plain',,
       hash('%sitename',ezini("SiteSettings","SiteURL")))}
{/set-block}
{/let}

{include uri="design:parts/mail/layout.tpl" html_content=$html_content subject=$subject}
