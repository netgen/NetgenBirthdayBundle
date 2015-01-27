
{if is_set($attribute_base)|not}{def $attribute_base='ContentObjectAttribute'}{/if}
{def $date=currentdate()
	 $byear=$date|datetime(custom,"%Y")}

<div class="date">
    <div class="col-lg-4">
        <label>{"Year"|i18n("dms/content/birthday")}</label>
        <select class="form-control" name="{$attribute_base}_birthday_year_{$attribute.id}" title="{"Please enter the year"|i18n("dms/content/birthday")}">
            <option value=""></option>
        {for $byear|inc to sub( $byear, 100 ) as $i}
             <option value="{$i}"{if eq($attribute.content.year, $i)} selected="selected"{/if}>{$i}</option>
        {/for}
        </select>
    </div>

    <div class="col-lg-4">
        <label>{"Month"|i18n("dms/content/birthday")}</label>
        <select class="form-control" name="{$attribute_base}_birthday_month_{$attribute.id}" title="{"Please enter the month"|i18n("dms/content/birthday")}">
            <option value=""></option>
        {for 1 to 12 as $i}
            <option value="{$i}"{if eq($attribute.content.month, $i)} selected="selected"{/if} >{$i}</option>
        {/for}
        </select>
    </div>

    <div class="col-lg-4">
        <label>{"Day"|i18n("dms/content/birthday")}</label>
        <select class="form-control" name="{$attribute_base}_birthday_day_{$attribute.id}" title="{"Please enter the day"|i18n("dms/content/birthday")}">
            <option value=""></option>
        {for 1 to 31 as $i}
            <option value="{$i}"{if eq($attribute.content.day, $i)} selected="selected"{/if}>{$i}</option>
        {/for}
        </select>
    </div>
</div>
