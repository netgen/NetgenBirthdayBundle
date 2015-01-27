<div class="row">
    <div class="col-lg-12">
        <div class="box">
            <div class="box-header" data-original-title>
                <h2><i class="fa fa-user"></i><span class="break"></span>{$node.object.data_map.name.content|wash()|d18n( 'dms/full/folder' )|upcase}</h2>
            </div>

            <div class="box-content">

                {if $node.object.data_map.description.has_content}
                    <div class="attribute-long"> <p>This is description attribute container</p>
                        {attribute_view_gui attribute=$node.object.data_map.description}
                    </div>
                {/if}

                {if is_unset( $versionview_mode )}
                    {def $page_limit = 10
                     $classes = ezini( 'MenuContentSettings', 'ExtraIdentifierList', 'menu.ini' )
                     $children = array()
                     $children_count = ''}

                {if le( $node.depth, '3')}
                    {set $classes = $classes|merge( ezini( 'ChildrenNodeList', 'ExcludedClasses', 'content.ini' ) )}
                {/if}

                {set $children_count=fetch( 'content', 'list_count', hash( 'parent_node_id', $node.node_id,
                                                                          'class_filter_type', 'exclude',
                                                                          'class_filter_array', $classes ) )}

                <div class="row">
                <div class="col-lg-12">
                <section class="content-view-children">
                    {if $children_count}
                        {foreach fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,
                                                                'offset', $view_parameters.offset,
                                                                'sort_by', $node.sort_array,
                                                                'class_filter_type', 'exclude',
                                                                'class_filter_array', $classes,
                                                                'limit', $page_limit ) ) as $child }
                            {node_view_gui view='line' content_node=$child}
                        {/foreach}
                    {/if}
                </section>
                </div>
                </div>
                {include name=navigator
                         uri='design:navigator/google.tpl'
                         page_uri=$node.url_alias
                         item_count=$children_count
                         view_parameters=$view_parameters
                         item_limit=$page_limit}
                {/if}
            </div>
        </div>
    </div><!--/col-->

</div><!--/row-->
