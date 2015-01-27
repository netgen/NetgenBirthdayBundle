{set-block variable=$action_items}
{if $node.can_create}
    <li>
        <a href="#" onclick="ezpopmenu_submitForm( 'create-reply' ); return false;">
            <i class="fa fa-plus-circle"></i>
            <p>{"New reply"|i18n( 'dms/full/forum' )}</p>
        </a>
        <form style="display: none" id="create-reply" method="post" action={"/content/action"|ezurl}>

            <input type="hidden" value="{$node.node_id}" name="ContentNodeID">
            <input type="hidden" value="{$node.contentobject_id}" name="ContentObjectID">
            <input type="hidden" value="{$node.node_id}" name="NodeID">
            <input type="hidden" value="forum_reply" name="ClassIdentifier">
            <input type="hidden" value="" name="NewButton">
            <input type="hidden" value="{$node.object.current_language}" name="ContentLanguageCode">

        </form>
    </li>
{/if}
{/set-block}

{set scope=global persistent_variable=hash('action_items', $action_items, 'full_view_scripts_bottom', array('ezpopupmenu.js'))}

{def $page_limit=15
     $reply_limit=cond( $view_parameters.offset|gt( 0 ), 20,
                       19 )
     $reply_offset=cond( $view_parameters.offset|gt( 0 ), sub( $view_parameters.offset, 1 ),
                        $view_parameters.offset )
     $reply_list=fetch('content','list', hash( parent_node_id, $node.node_id,
                                              limit, $reply_limit,
                                              offset, $reply_offset,
                                              sort_by, array( array( published, true() ) ) ) )
     $reply_count=fetch('content','list_count', hash( parent_node_id, $node.node_id ) ) }


<div class="row">
  <div class="col-lg-12 discussions">
    <div class="box">
      <div class="box-header" data-original-title>
          <h2><i class="fa fa-comments"></i><span class="break"></span>{$node.name|wash}</h2>
          <div class="box-icon">
            {if is_unset( $versionview_mode )}
              <a href={$node.parent.url_alias|ezurl} alt="{$node.parent.name|wash}" title="{$node.parent.name|wash}"><a class="forum-up" href={$node.parent.url_alias|ezurl}>{"Go up"|i18n( "dms/full/forum" )}</a></a>
            {/if}
          </div>
      </div>
      <div class="box-content">
        {*include uri='design:ajax/forum_reply.tpl'*}
        <ul>
          <li>
            {def $owner = $node.object.owner
               $owner_map = $owner.data_map
               $owner_id = $node.object.owner_id}

            <div class="author">
              {if $owner_map.image.has_content}
                {attribute_view_gui attribute=$owner_map.image image_class='dms_userthumbnail'}
              {else}
                <img src="/share/icons/crystal-admin/32x32/apps/personal.png" alt="avatar" />
              {/if}
            </div>
            <div class="name">
              {$owner.name|wash}{if is_set( $owner_map.title )}, {$owner_map.title.content|wash}{/if}
              {if is_set( $owner_map.location )}, {"Location"|i18n( "dms/full/forum_topic" )}: {$owner_map.location.content|wash}{/if}
              {foreach $node.object.author_array as $author}
                {if eq($owner_id,$author.contentobject_id)|not()}
                  , {"Moderated by"|i18n( "dms/full/forum_topic" )}: {$author.contentobject.name|wash}
                {/if}
              {/foreach}
            </div>
            <div class="date">{$node.object.published|l10n(datetime)}</div>
            <div class="message">
              {attribute_view_gui attribute=$node.object.data_map.message}
              {if $node.object.can_edit}
              <div class="float-break pull-right">
                <form id="edit-reply" action={"/content/action"|ezurl} method="post">
                  <input type="submit" name="EditButton" class="btn" value="{'Edit'|i18n("dms/full/forum_topic")}" />
                  {*<input type="submit" name="RemoveButton" class="btn btn-danger" value="{'Delete'|i18n("dms/full/forum_topic")}" />*}

                  <input type="hidden" name="ContentObjectID" value="{$node.object.id}">
                  <input type="hidden" name="ContentNodeID" value="{$node.node_id}">

                  <input type="hidden" name="ContentObjectLanguageCode" value="{$node.object.current_language}">

                  <input type="hidden" name="RedirectURIAfterRemove" value={$node.parent.url_alias|ezurl()}>
                  <input type="hidden" name="RedirectIfCancel" value={$node.parent.url_alias|ezurl()}>
                  <input type="hidden" name="CancelURI" value={$node.parent.url_alias|ezurl()}>
                </form>
              </div>
              {/if}
            </div>

            {undef $owner $owner_map $owner_id}

            {include uri='design:ajax/init.tpl' classIdentifier='forum_reply' actionName='New Reply'|i18n( 'dms/full/forum_topic' ) showBottomControls=true()}
          </li>
        </ul>
      </div>
    </div>
  </div>
</div>
