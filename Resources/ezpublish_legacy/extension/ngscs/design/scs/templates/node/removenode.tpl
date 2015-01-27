<div class="alert alert-danger">
<h4 class="alert-heading">{"Are you sure you want to remove %1 from node %2?"|i18n("design/standard/node",,hash("%1",$object.name|wash,"%2",$node.object.name|wash))}</h4>
<ul>
    <li>{"Removing this assignment will also remove its %1 children."|i18n("design/standard/node",,hash("%1",$ChildObjectsCount))}</li>
</ul>
</div>

<p><b>{"Note:"|i18n("design/standard/node")}</b> {"Removed nodes can be retrieved later. You will find them in the trash."|i18n("design/standard/node")}</p>

<form enctype="multipart/form-data" method="post" action={concat("/content/removenode/",$object.id,"/",$edit_version,"/",$node.node_id,"/")|ezurl}>

<h1>{"Removing node assignment of %1"|i18n("design/standard/node",,array($object.name|wash))}</h1>

<input type="hidden" name=RemoveNodeID value={$node.parent_node_id} />
<input class="btn btn-danger" type="submit" name="ConfirmButton" value="{"Confirm"|i18n("design/standard/node")}">
<input class="btn" type="submit" name="CancelButton" value="{"Cancel"|i18n("design/standard/node")}">

</form>
