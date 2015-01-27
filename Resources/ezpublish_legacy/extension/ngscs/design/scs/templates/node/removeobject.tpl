
{if is_unset( $exceeded_limit ) }
    {def $exceeded_limit=false()};
{/if}
<form action={concat($module.functions.removeobject.uri)|ezurl} method="post" name="ObjectRemove">

<div class="alert alert-danger">
{if eq( $exceeded_limit, true() )}
<h4 class="alert-heading">Warning:</h4>
<p>{'The items contain more than the maximum possible nodes for subtree removal and will not be deleted. You can remove this subtree using the ezsubtreeremove.php script.'|i18n( 'design/ezwebin/node/removeobject' )}</p>
{else}
<h4>{"Are you sure you want to remove these items?"|i18n("design/starndard/node")}</h4>
{/if}
<ul>
{section name=Result loop=$DeleteResult}
    {if $Result:item.childCount|gt(0)}
        <li>{"%nodename and its %childcount children. %additionalwarning"
             |i18n( 'design/standard/node',,
                    hash( '%nodename', $Result:item.nodeName,
                          '%childcount', $Result:item.childCount,
                          '%additionalwarning', $Result:item.additionalWarning ) )}</li>
    {else}
        <li>{"%nodename %additionalwarning"
             |i18n( 'design/standard/node',,
                    hash( '%nodename', $Result:item.nodeName,
                          '%additionalwarning', $Result:item.additionalWarning ) )}</li>
    {/if}
{/section}
</ul>
</div>

{if and( $move_to_trash_allowed, eq( $exceeded_limit, false() ) )}
  <input type="hidden" name="SupportsMoveToTrash" value="1" />
  <p><input type="checkbox" name="MoveToTrash" value="1" checked="checked" />{'Move to trash'|i18n('design/standard/node')}</p>

  <p><b>{"Note"|i18n("design/standard/node")}:</b> {"If %trashname is checked you will find the removed items in the trash afterward."
                                                    |i18n( 'design/standard/node',,
                                                           hash( '%trashname', concat( '<i>', 'Move to trash' | i18n( 'design/standard/node' ), '</i>' ) ) )}</p>
  <br/>
{/if}

<input class="btn btn-danger" type="submit" name="ConfirmButton" value="{"Confirm"|i18n("design/standard/node")}">
<input class="btn" type="submit" name="CancelButton" value="{"Cancel"|i18n("design/standard/node")}">


</form>
