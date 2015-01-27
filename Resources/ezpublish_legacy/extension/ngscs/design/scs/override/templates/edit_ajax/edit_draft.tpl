{let has_own_drafts=false()
     has_other_drafts=false()
     current_creator=fetch(user,current_user)}
{section loop=$draft_versions}
    {if eq($item.creator_id,$current_creator.contentobject_id)}
        {set has_own_drafts=true()}
    {else}
        {set has_other_drafts=true()}
    {/if}
{/section}
<form method="post" action={concat('content/edit/',$object.id,'/f/',$edit_language,'/',$from_language)|ezurl} id="draft">

    <div class="modal-header">
        <input type="submit" class="close" name="DiscardButton" value="&times;" />
        <h4 class="modal-title">{$object.name|wash}</h4>
    </div>

    <div class="modal-body">
        <div class="row">
            <div class="col-lg-12">
                <div class="context-block">
                    <div class="alert alert-warning">
                            <p>
                        {"The currently published version is %version and was published at %time."|i18n('design/standard/content/edit',,hash('%version',$object.current_version,'%time',$object.published|l10n(datetime) ))}
                        </p>
                        <p>
                        {"The last modification was done at %modified."|i18n('design/standard/content/edit',,hash('%modified',$object.modified|l10n(datetime)))}
                        </p>
                        <p>
                        {"The object is owned by %owner."|i18n('design/standard/content/edit',,hash('%owner',$object.owner.name))}
                        </p>

                        {if and($has_own_drafts,$has_other_drafts)}
                        <p>
                           {"This object is already being edited by yourself or someone else.
                            You can either continue editing one of your drafts or you can create a new draft."|i18n('design/standard/content/edit')}
                        </p>
                        {else}
                            {if $has_own_drafts}
                            <p>
                              {"This object is already being edited by you.
                                You can either continue editing one of your drafts or you can create a new draft."|i18n('design/standard/content/edit')}
                            </p>
                            {/if}
                            {if $has_other_drafts}
                            <p>
                              {"This object is already being edited by someone else.
                                You should either contact the person about the draft or create a new draft for personal editing."|i18n('design/standard/content/edit')}
                            </p>
                            {/if}
                        {/if}
                    </div>


                    <h2>{'Current drafts'|i18n('design/standard/content/edit')}</h2>

                    <table class="table table-striped table-bordered" >
                    <tr>
                        {if $has_own_drafts}
                            <th>&nbsp;</th>
                        {/if}
                        <th>{'Version'|i18n('design/standard/content/edit')}</th>
                        <th>{'Name'|i18n('design/standard/content/edit')}</th>
                        <th>{'Owner'|i18n('design/standard/content/edit')}</th>
                        <th>{'Created'|i18n('design/standard/content/edit')}</th>
                        <th>{'Last modified'|i18n('design/standard/content/edit')}</th>
                    </tr>
                    {section name=Draft loop=$draft_versions sequence=array(bglight,bgdark)}
                    <tr class="{$:sequence}">
                        {if $has_own_drafts}
                            <td width="1">
                                {if eq($:item.creator_id,$current_creator.contentobject_id)}
                                    <input type="radio" name="SelectedVersion" value="{$:item.version}"
                                        {run-once}
                                            checked="checked"
                                        {/run-once}
                                     />
                                {/if}
                            </td>
                        {/if}
                        <td width="1">{$:item.version}</td>
                        <td> <a href={concat('content/versionview/',$object.id,'/',$:item.version)|ezurl}>{$:item.version_name|wash}</a></td>
                        <td>{content_view_gui view=text_linked content_object=$:item.creator}</td>
                        <td>{$:item.created|l10n(shortdatetime)}</td>
                        <td>{$:item.modified|l10n(shortdatetime)}</td>
                    </tr>
                    {/section}
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        {if and($has_own_drafts,$has_other_drafts)}
            <input class="btn btn-primary" type="submit" name="EditButton" value="{'Edit'|i18n('design/standard/content/edit')}" />
            <input class="btn" type="submit" name="NewDraftButton" value="{'New draft'|i18n('design/standard/content/edit')}" />
        {else}
            {if $has_own_drafts}
                <input class="btn btn-primary" type="submit" name="EditButton" value="{'Edit'|i18n('design/standard/content/edit')}" />
                <input class="btn" type="submit" name="NewDraftButton" value="{'New draft'|i18n('design/standard/content/edit')}" />
            {/if}
            {if $has_other_drafts}
                <input class="btn" type="submit" name="NewDraftButton" value="{'New draft'|i18n('design/standard/content/edit')}" />
            {/if}
        {/if}
    </div>

</form>

{/let}
