{set-block variable=$headline_open}
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="default-container"><tr>
        <td valign="middle" style="font-size: 20px; line-height: 26px; color: #fff; font-family: Verdana;">
{/set-block}
{set-block variable=$headline_close}
        </td>
    </tr></table>
    <br />
{/set-block}
{set-block variable=$content_wrapper_open}
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="default-container"><tr>
        <td valign="middle" style="font-size: 14px; line-height: 20px; color: #b0b0b0; font-family: Verdana;">
{/set-block}
{set-block variable=$content_wrapper_close}
        </td>
    </tr></table>
    <br />
{/set-block}
{* Template start *}
{include uri="design:parts/mail/header.tpl" subject=$subject}

{$headline_open}
{$subject}
{$headline_close}

<!-- MAIN BANNER with TITLE, SUBTITLE, DESCRIPTION and BUTTON -->
{$content_wrapper_open}
{$html_content}
{$content_wrapper_close}
<!-- /MAIN BANNER with TITLE, SUBTITLE, DESCRIPTION and BUTTON -->

{include uri="design:parts/mail/footer.tpl" subject=$subject}
