{let can_edit=false()}
<div class="row">
    <div class="col-lg-12">
        <div class="box">
            <div class="box-header" data-original-title>
                <h2><i class="fa fa-bookmark"></i><span class="break"></span>{"My bookmarks"|i18n("dms/content/bookmark")}</h2>
                <div class="box-icon">
                    <a href={concat("content/bookmark", '#')|ezurl} class="btn-minimize"><i class="fa fa-chevron-up"></i></a>
                </div>
            </div>

            <div class="box-content">

                <form action={concat("content/bookmark/")|ezurl} method="post" >

                {let bookmark_list=fetch('content','bookmarks',array())}

                {section show=$bookmark_list}

                <p>
                    {"These are the objects you have bookmarked. Click on an object to view it or if you have permission you can edit the object by clicking the edit button.
                      If you want to add more objects to this list click the %emphasize_startAdd bookmarks%emphasize_stop button.

                      Removing objects will only remove them from this list."
                      |i18n("dms/content/bookmark",,
                            hash( '%emphasize_start', '<i>',
                                  '%emphasize_stop', '</i>' ) )
                      |nl2br}
                </p>

                {section loop=$bookmark_list}
                  {section show=$:item.node.object.can_edit}
                    {set can_edit=true()}
                  {/section}
                {/section}

                <table class="table table-striped table-bordered bootstrap-datatable datatable">
                <tr>
                    <th width="1%">
                    {"Select"|i18n("dms/content/bookmark")}
                    </th>
                    <th width="69%">
                            {"Name"|i18n("dms/content/bookmark")}
                    </th>
                    <th width="14%">
                            {"Type"|i18n("dms/content/bookmark")}
                    </th>
                </tr>

                {section name=Bookmark loop=$bookmark_list sequence=array(bgdark,bglight)}
                <tr class="{$:sequence}">
                    <td align="left">
                        <input type="checkbox" name="DeleteIDArray[]" value="{$:item.id}" />
                    </td>

                    <td>
                        <a href={$:item.node.url_alias|ezurl}>{*$:item.node.object.content_class.identifier|class_icon( small, $:item.node.object.content_class.name )*}&nbsp;{$:item.node.name|wash}</a>
                    </td>

                    <td>
                        {$:item.node.object.content_class.name|d18n('dms/content/bookmark')}
                    </td>
                </tr>
                {/section}

                </table>
                <div class="buttonblock">
                    <input class="btn btn-large btn-danger" type="submit" name="RemoveButton" value="{"Remove selected"|i18n('dms/content/bookmark')}" />
                </div>
                {section-else}

                <div class="feedback">
                    <h2>{"You have no bookmarks"|i18n("dms/content/bookmark")}</h2>
                </div>

                {/section}


                </form>

                {/let}
            </div>
        </div>
    </div><!--/col-->

</div><!--/row-->
{/let}

