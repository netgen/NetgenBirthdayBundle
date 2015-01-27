{set-block variable=$action_items}
{if $node.can_edit}
    <li>
        <a onclick="ezpopmenu_submitForm( 'edit' ); return false;" href="#">
            <i  class="fa fa-pencil"></i>
            <p>{"Edit"|i18n("design/standard/node/view")}</p>
        </a>
        <form method="post" action={"/content/action"|ezurl} id="edit">
            <input type="hidden" name="NodeID" value="{$node.node_id}" />
            <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
            <input type="hidden" name="EditButton" value="" />
            <input type="hidden" name="ContentObjectLanguageCode" value="{$node.object.current_language}" />
        </form>
    </li>
{/if}
{if $node.can_remove}
    <li>
        <a onclick="ezpopmenu_submitForm( 'remove' ); return false;" href="#">
            <i class="fa fa-times-circle"></i>
            <p>{"Remove"|i18n("design/standard/node/view")}</p>
        </a>
        <form method="post" action={"/content/action"|ezurl} id="remove">
            <input type="hidden" name="ContentNodeID"  value="{$node.node_id}" />
            <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
            <input type="hidden" name="ActionRemove" value="" />
            <input type="hidden" name="SupportsMoveToTrash" value="1" />
            <input type="hidden" name="MoveToTrash" value="1" />
        </form>
    </li>
{/if}
    <li>
        <a onclick="ezpopmenu_submitForm( 'bookmark' ); return false;" href="#">
            <i  class="fa fa-bookmark"></i>
            <p>{'Add to Bookmarks'|i18n('design/standard/node/view')}</p>
        </a>
        <form method="post" action={"/content/action"|ezurl} id="bookmark">
            <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
            <input type="hidden" name="ActionAddToBookmarks" value="" />
        </form>
    </li>
    <li>{* My notifications *}
    {include uri='design:page_subscriber_menu.tpl'}
    </li>
{/set-block}

{set scope=global persistent_variable=hash('action_items', $action_items, 'full_view_scripts_bottom', array('ezpopupmenu.js'))}

<div class="row">
    <div class="col-lg-12">

        <h1>{$node.name|wash}</h1>

        <div class="box">
            <div class="box-header" data-original-title>
                <h2><i class="fa fa-th"></i><span class="break"></span>{'Content'|i18('design/standard/node/view')}</h2>
            </div>

            <div class="box-content">
                {foreach $node.contentobject_version_object.contentobject_attributes as $i => $item}

                    <label for="attr{$item.contentclass_attribute.id}">{$i|inc}. {$item.contentclass_attribute.name|wash}</label>
                    <p id="attr{$item.contentclass_attribute.id}">{attribute_view_gui attribute=$item}</p>
                {/foreach}
            </div>
        </div>

        <form method="post" action={"/content/action"|ezurl} >
            <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
            <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
            <input type="hidden" name="ViewMode" value="full" />

            <div class="box">
                <div class="box-header" data-original-title>
                    <h2><i class="fa fa-folder"></i><span class="break"></span>{'Sub items'|i18('design/standard/node/view')}</h2>
                    <div class="box-icon">
                        <a href={concat($node.url_alias, '#')|ezurl} class="btn-minize"><i class="fa fa-chevron-up"></i></a>
                    </div>
                </div>

                <div class="box-content">

                {let page_limit=2 list_count=fetch('content','list_count',hash(parent_node_id,$node.node_id,depth_operator,eq))}

                    {if $list_count}

                            {let children=fetch('content','list',hash(parent_node_id,$node.node_id,sort_by,$node.sort_array,limit,$page_limit,offset,$view_parameters.offset,depth_operator,eq))}

                            {if $children}

                            <table class="table table-striped table-bordered clickable">
                            <tr>
                                <th>
                                  {"Name"|i18n("design/standard/node/view")}
                                </th>
                                <th>
                                  {"Class"|i18n("design/standard/node/view")}
                                </th>
                                <th>
                                  {"Section"|i18n("design/standard/node/view")}
                                </th>
                                {if eq($node.sort_array[0][0],'priority')}
                                <th>
                                  {"Priority"|i18n("design/standard/node/view")}
                                    {if and($node.object.can_edit,eq($node.sort_array[0][0],'priority'))}
                                        <input class="btn btn-mini" type="submit"  name="UpdatePriorityButton" value="{'Update'|i18n('design/standard/node/view')}" />
                                    {/if}
                                </th>
                                {/if}
                            </tr>
                            {foreach $children as $item}
                            <tr>
                                <td>
                                    {node_view_gui view=listitem content_node=$item}
                                </td>
                                <td>
                                    {$item.object.class_name|wash}
                                </td>
                                <td>
                                    {$item.object.section_id}
                                </td>
                                {if eq($node.sort_array[0][0],'priority')}
                                <td align="left">
                                    <input type="text" name="Priority[]" size="2" value="{$item.priority}">
                                    <input type="hidden" name="PriorityID[]" value="{$item.node_id}">
                                </td>
                                {/if}

                            </tr>
                            {/foreach}
                            </table>

                            {/if}
                            {/let}

                    {/if}

                    {include name=navigator
                    uri='design:navigator/google.tpl'
                    page_uri=concat('/content/view','/full/',$node.node_id)
                    item_count=$list_count
                    view_parameters=$view_parameters
                    item_limit=$page_limit}

                    {if $node.object.can_create}
                    <div class="row">
                        <div class="col-lg-6">
                        <input type="hidden" name="NodeID" value="{$node.node_id}" />
                        <select name="ClassID" class="form-control" style="width: 40%; float: left; margin-right: 10px;">
                            {section name=Classes loop=$node.object.can_create_class_list}
                                <option value="{$:item.id}">{$:item.name|wash}</option>
                            {/section}
                        </select>
                        <input class="btn btn-primary" type="submit" name="NewButton" value="{'Create here'|i18n('design/standard/node/view')}" />
                        </div>
                    </div>
                    {/if}
                {/let}
                </div>
            </div>
        </form>

    </div>
</div>

