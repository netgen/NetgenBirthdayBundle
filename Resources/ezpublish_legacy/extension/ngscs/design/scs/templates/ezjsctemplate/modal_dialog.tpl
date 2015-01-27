{*if is_unset( $attribute_id )}{def $attribute_id = '0'}{/if*}
{include uri='design:ezjsctemplate/tree_menu_script.tpl' menu_persistence=false()}

<div class="modal parent-selector-tree" id="parent-selector-tree-{$attribute_id}">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close jqmClose" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">{'Select tag'|i18n( 'dms/tags' )}</h4>
            </div>
            <div class="modal-body">
                <div id="content-tree-{$attribute_id}">
                    <div class="contentstructure">
                    {if and( is_set( $root_tag ), $root_tag|is_array )}
                        {foreach $root_tag as $key => $value}
                            {include uri='design:ezjsctemplate/tree_menu.tpl' attribute_id=concat( $attribute_id, '_', $key ) root_tag=$value}
                            {delimiter}<hr />{/delimiter}
                        {/foreach}
                    {else}
                        {include uri='design:ezjsctemplate/tree_menu.tpl' attribute_id=$attribute_id root_tag=cond( is_set( $root_tag ), $root_tag, false() )}
                    {/if}
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default jqmClose" data-dismiss="modal">Close</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
$(function(){ldelim}
    $('#parent-selector-tree-{$attribute_id}').draggable({ldelim}
        handle: ".modal-header"
    {rdelim});
{rdelim});
</script>

