{def $page_limit=30
     $can_edit=false()}
<div class="row">
  <div class="col-lg-12">
    <div class="box">
      <form action={concat("ngbookmark/bookmark/")|ezurl} method="post" >
        <div class="box-header">
          <h2><i class="fa fa-search"></i><span class="break"></span>{"My saved searches"|i18n("dms/content/bookmark")}</h2>
        </div>
        {def $bookmark_list=fetch('ngbookmark','bookmarks',hash('name', ''))}

        {if $bookmark_list}
        <div class="box-content">
          <p>
              {"These are the searches you have saved. Click on a link to view it."
                |i18n("dms/content/bookmark",,
                      hash( '%emphasize_start', '<i>',
                            '%emphasize_stop', '</i>' ) )
                |nl2br}
          </p>

          {foreach $bookmark_list as $item}
            {if $item.node.object.can_edit}
              {set $can_edit=true()}
            {/if}
          {/foreach}

          <table class="table table-striped table-bordered" width="100%" cellspacing="0" cellpadding="0" border="0">
          <thead>
          <tr>
              <th width="1">
              </th>
              <th width="69%">
                  {"Name"|i18n("dms/content/bookmark")}
              </th>
              <th width="30%">
                  {"Type"|i18n("dms/content/bookmark")}
              </th>
          </tr>
          </thead>
          <tbody>
          {foreach $bookmark_list as $item sequence array(bgdark,bglight) as $order}
          <tr class="{$order}">
              <td align="left">
                  <input type="checkbox" name="DeleteIDArray[]" value="{$item.id}" />
              </td>

              <td>
                  <a href={urldecode($item.url)|ezurl}>{$item.title}</a>
              </td>

              <td>
                  {$item.name|wash}
              </td>

          </tr>
          {/foreach}
          </tbody>
          </table>
          <div class="buttonblock">
              <input class="btn btn-danger" type="submit" name="RemoveButton" value="{"Remove selected"|i18n('dms/content/bookmark')}" />
          </div>

          {else}

          <div class="feedback">
              <h2>{"You have no saved searches"|i18n("dms/content/bookmark")}</h2>
          </div>

          {/if}
        </div>

      </form>
    </div>
  </div>
</div>
