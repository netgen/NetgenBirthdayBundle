{if ezini( 'RegionalSettings', 'Locale', 'site.ini' )|ne('eng-GB')}
    <ul class="actions-nav">
    {if $node.can_edit}
        <li>
            {if $node.object.language_codes|contains(ezini( 'RegionalSettings', 'Locale', 'site.ini' ))|not}
                <a href="#" onclick="ezpopmenu_submitForm( 'translate' ); return false;">
                    <i class="fa fa-pencil"></i>
                    <p>{"Translate from english"|i18n( 'dms_armenia/agencies/full' )}</p>
                </a>
                <form method="post" action={concat("/content/edit/", $node.contentobject_id)|ezurl} id="translate">
                    <input type="hidden" name="EditLanguage" value="{ezini( 'RegionalSettings', 'Locale', 'site.ini' )}" />
                    <input type="hidden" name="FromLanguage" value="eng-GB" />
                    <input type="hidden" name="LanguageSelection" value="Edit" />
                </form>
            {else}
                <a onclick="ezpopmenu_submitForm( 'edit' ); return false;" href="#">
                    <i  class="fa fa-pencil"></i>
                    <p>{"Edit"|i18n("dms/full/agency")}</p>
                </a>
                <form method="post" action={"/content/action"|ezurl} id="edit">
                    <input type="hidden" name="NodeID" value="{$node.node_id}" />
                    <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                    <input type="hidden" name="EditButton" value="" />
                    <input type="hidden" name="ContentObjectLanguageCode" value="{$node.object.current_language}" />
                </form>
            {/if}
        </li>
    {/if}
    </ul>
{/if}