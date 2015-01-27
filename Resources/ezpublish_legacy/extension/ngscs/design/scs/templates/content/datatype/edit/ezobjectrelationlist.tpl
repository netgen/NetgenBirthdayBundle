{let class_content=$attribute.class_content
    attribute_base='ContentObjectAttribute'}


    <div class="block 11123" id="ezobjectrelationlist_browse_{$attribute.id}">

        <table class="table table-striped table-bordered list{if $attribute.content.relation_list|not} hide{/if}" cellspacing="0">
        <thead>
        <tr>
            <th class="tight"></th>
            <th>{'Name'|i18n( 'dms/content/relation_list' )}</th>
            <th class="tight" width="10%">{'Order'|i18n( 'dms/content/relation_list' )}</th>
        </tr>
        </thead>
        <tbody>
        {if $attribute.content.relation_list}
            {foreach $attribute.content.relation_list as $item sequence array( 'bglight', 'bgdark' ) as $style}
              {def $object = fetch( content, object, hash( object_id, $item.contentobject_id ) )}
              <tr class="{$style}">
                {* Remove. *}
                <td><input type="checkbox" name="{$attribute_base}_selection[{$attribute.id}][]" value="{$item.contentobject_id}" />
                <input type="hidden" name="{$attribute_base}_data_object_relation_list_{$attribute.id}[]" value="{$item.contentobject_id}" /></td>

                {* Name *}
                <td>{if and($object.data_map.id, $object.data_map.name)}{$object.data_map.id.content|wash()}: {$object.data_map.name.content|wash()}{else}{$object.name|wash}{/if}</td>

                {* Order. *}
                <td><input class="form-control" size="2" type="text" name="{$attribute_base}_priority[{$attribute.id}][]" value="{$item.priority}" /></td>

              </tr>
              {undef $object}
            {/foreach}
        {else}
          <tr class="bgdark">
            <td><input type="checkbox" name="{$attribute_base}_selection[{$attribute.id}][]" value="--id--" />
            <input type="hidden" name="{$attribute_base}_data_object_relation_list_{$attribute.id}[]" value="no_relation" /></td>
            <td>--name--</td>
            <td>--class-name--</td>
            <td>--section-name--</td>
            <td>--published--</td>
            <td><input class="form-control" size="2" type="text" name="{$attribute_base}_priority[{$attribute.id}][]" value="0" /></td>
          </tr>
        {/if}
        </tbody>
        </table>
        {if $attribute.content.relation_list|not}
            <p class="ezobject-relation-no-relation">{'There are no related objects.'|i18n( 'dms/content/relation_list' )}</p>
        {/if}

        <div class="block inline-block">
	        {if $attribute.content.relation_list}
	            <input class="btn btn-danger button ezobject-relation-remove-button" type="submit" name="CustomActionButton[{$attribute.id}_remove_objects]" value="{'Remove selected'|i18n( 'dms/content/relation_list' )}" title="{'Remove selected elements from the relation'|i18n( 'dms/content/relation_list' )}" />
	        {else}
	            <input class="btn btn-danger button-disabled ezobject-relation-remove-button" type="submit" name="CustomActionButton[{$attribute.id}_remove_objects]" value="{'Remove selected'|i18n( 'dms/content/relation_list' )}" disabled="disabled" />
	        {/if}
        </div>
        <div class="left form-inline">
            <input type="text" class="form-control halfbox hide ezobject-relation-search-text" />
            <input type="submit" class="btn btn-primary button hide ezobject-relation-search-btn" name="CustomActionButton[{$attribute.id}_browse_objects]" value="{'Find objects'|i18n( 'dms/content/relation_list' )}" />

            {if is_set( $attribute.class_content.class_constraint_list[0] )}
                <input type="hidden" name="{$attribute_base}_browse_for_object_class_constraint_list[{$attribute.id}]" value="{$attribute.class_content.class_constraint_list|implode(',')}" />
            {/if}

        </div>
        <div class="break"></div>
        <div class="block inline-block ezobject-relation-search-browse hide"></div>

        {include uri='design:content/datatype/edit/ezobjectrelation_ajax_search.tpl'}

    </div><!-- /div class="block" id="ezobjectrelationlist_browse_{$attribute.id}" -->

{/let}
