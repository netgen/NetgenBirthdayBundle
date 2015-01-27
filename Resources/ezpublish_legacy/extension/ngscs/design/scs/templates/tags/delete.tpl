{def $children_object_count = 0}
{def $synonym_object_count = 0}



<div class="box">

    <div class="box-header">
        <h2><i class="fa fa-pencil"></i>{"Delete tag"|i18n( 'dms/tags' )}: {$tag.keyword|wash} [{$tag.id}]</h2>
        {* <p><img src="{$language.locale|flag_icon}" title="{$language.name|wash}" /> {$language.name|wash}</p>
        <p>{if $is_main_translation|not}{'Main translation'|i18n( 'dms/tags' )}: {$tag.main_translation.keyword|wash}{/if}</p> *}
        <div class="box-icon">
            <a class="btn-minimize" href="/Users#"><i class="fa fa-chevron-up"></i></a>
        </div>
    </div>

    {if $delete_allowed}
        <div class="box-content">

            {if or($error|count, $warning|count)}
                <div id="messagebox">
                    {if $error|count}
                            <div class="alert alert-warning">
                                <button data-dismiss="alert" class="close" type="button">×</button>
                                <h4 class="alert-heading">Warning!</h4>
                                <p>{$error|wash}</p>
                            </div>
                    {/if}

                    {if $warning|count}
                        <div class="alert alert-warning">
                            <button data-dismiss="alert" class="close" type="button">×</button>
                            <h4 class="alert-heading">Warning!</h4>
                            <p>{$warning|wash}</p>
                        </div>
                    {/if}
                </div>
            {/if}

            <div class="alert alert-warning">
                <button data-dismiss="alert" class="close" type="button">×</button>
                <h4 class="alert-heading">Warning!</h4>
                <p>{'Are you sure you want to delete the "%keyword" tag? All children tags and synonyms will also be deleted and removed from existing objects.'|i18n( 'dms/tags', , hash( '%keyword', $tag.keyword|wash ) )}</p>
            </div>

            <form name="tagdeleteform" id="tagdeleteform" enctype="multipart/form-data" method="post" action={concat( 'tags/delete/', $tag.id )|ezurl}>
                <p>{"The tag you're about to delete has"|i18n( 'dms/tags' )}:</p>
                <ul>
                    <li>{'number of first level children tags'|i18n( 'dms/tags' )}: {$tag.children_count}</li>
                    {foreach $tag.children as $child}{set $children_object_count = $children_object_count|sum( $child.related_objects_count )}{/foreach}
                    <li>{'number of objects related to first level children tags'|i18n( 'dms/tags' )}: {$children_object_count}</li>
                    <li>{'number of synonyms'|i18n( 'dms/tags' )}: {$tag.synonyms_count}</li>
                    {foreach $tag.synonyms as $synonym}{set $synonym_object_count = $synonym_object_count|sum( $synonym.related_objects_count )}{/foreach}
                    <li>{'number of objects related to synonyms'|i18n( 'dms/tags' )}: {$synonym_object_count}</li>
                </ul>

                <div class="form-actions">
                    <input class="btn btn-success" type="submit" name="YesButton" value="{'Yes'|i18n( 'dms/tags' )}" />
                    <input class="btn" type="submit" name="NoButton" value="{'No'|i18n( 'dms/tags' )}" />
                </div>
            </form>
        </div>
    {else}
        <div class="controlbar">
            <div class="block">
                <input class="button" type="button" onclick="javascript:history.back();" value="{'Go back'|i18n( 'dms/tags' )}" />
            </div>
        </div>
    {/if}
</div>

{undef}
