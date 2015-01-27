{def $page_limit=30
     $list_count=fetch('content','draft_count')}

<form name="draftaction" action={concat("content/draft/")|ezurl} method="post" >
    <div class="row">
        <div class="col-lg-11 col-sm-10">
            <div class="box">
                <div class="box-header">
                    <h2><i class="fa fa-pencil-square"></i><span class="break"></span>{"My drafts"|i18n("design/standard/content/view")}</h2>
                </div>
                <div class="box-content">
                    {if $list_count}
                        <p>
                            {"These are the current objects you are working on. The drafts are owned by you and can only be seen by you.
      You can either edit the drafts or remove them if you do not need them any more."|i18n("design/standard/content/view")|nl2br}
                        </p>

                        <table class="clickable table table-striped table-bordered" width="100%" cellspacing="0" cellpadding="0" border="0">
                            <tr>

                                <th>
                                    <input type="checkbox" name="selectall" value="" id="selectall" checked/>
                                    {*<input name="selectall" class="btn fa-input fa-check-square-o" onclick=checkAll() type="button" value="{'Select all'|i18n('design/standard/content/view')}"></th>*}
                                <th>{"Name"|i18n("design/standard/content/view")}</th>
                                <th>{"Class"|i18n("design/standard/content/view")}</th>
                                <th>{"Version"|i18n("design/standard/content/view")}</th>
                                <th>{"Language"|i18n("design/standard/content/view")}</th>
                                <th>{"Last modified"|i18n("design/standard/content/view")}</th>
                                <th>{"Edit"|i18n("design/standard/content/view")}</th>
                            </tr>
                            {foreach fetch( 'content', 'draft_version_list', hash( limit, $page_limit, offset, $view_parameters.offset ) ) as $draft}
                                <tr>
                                    <td align="left" width="1">
                                        <input type="checkbox" name="DeleteIDArray[]" value="{$draft.id}" />
                                    </td>
                                    <td>
                                        <a href={concat("/content/versionview/",$draft.contentobject.id,"/",$draft.version,"/")|ezurl}>{$draft.contentobject.content_class.identifier|class_icon( small, $draft.contentobject.content_class.name )}&nbsp;{$draft.version_name|wash}</a>
                                    </td>
                                    <td>
                                        {$draft.contentobject.content_class.name|wash}
                                    </td>
                                    <td>
                                        {$draft.version}
                                    </td>
                                    <td>
                                        <img src="{$draft.initial_language.locale|flag_icon}" alt="{$draft.initial_language.locale|wash}" />&nbsp;{$draft.initial_language.name|wash}
                                    </td>
                                    <td>
                                        {$draft.modified|l10n(datetime)}
                                    </td>
                                    <td width="1">
                                        <a href={concat("/content/edit/",$draft.contentobject.id,"/",$draft.version,"/")|ezurl}><i class="fa fa-pencil"></i></a>
                                    </td>
                                </tr>
                            {/foreach}
                        </table>
                        <div class="controls">
                            <input type="submit" class="btn btn-danger" name="RemoveButton" value="{'Remove'|i18n('design/standard/content/view')}" />
                        </div>

                        {include name=navigator
                            uri='design:navigator/google.tpl'
                            page_uri='/content/draft'
                            item_count=$list_count
                            view_parameters=$view_parameters
                            item_limit=$page_limit}

                    {else}

                        <div class="feedback">
                            <h2>{"You have no drafts"|i18n("design/standard/content/view")}</h2>
                        </div>

                    {/if}
                </div>
            </div>
        </div>
    </div>
</form>

<script type="text/javascript">
    {literal}
    $("#selectall").on('click', function(){
        if ( $(this).is(":checked") ){
            with (document.draftaction){
                for (var i=0; i < elements.length; i++){
                    if (elements[i].type == 'checkbox' && elements[i].name == 'DeleteIDArray[]')
                        elements[i].checked = false;
                }
            }
        }else{
            with (document.draftaction){
                for (var i=0; i < elements.length; i++){
                    if (elements[i].type == 'checkbox' && elements[i].name == 'DeleteIDArray[]')
                        elements[i].checked = true;
                }
            }
        }
    });
    {/literal}
</script>