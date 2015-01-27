{*?template charset=UTF-8*}
{def
    $choose1 = ezini( 'NumberPerPage', 'choose1', 'owtranslate.ini' )
    $choose2 = ezini( 'NumberPerPage', 'choose2', 'owtranslate.ini' )
    $choose3 = ezini( 'NumberPerPage', 'choose3', 'owtranslate.ini' )
}

<div class="clearfix text-center">
<ul class="pagination">
    <li{if eq($limit, $choose1)} class="active"{/if}>
        <a href={concat('translate/',$view , '/(limit)/', $choose1, cond(ne($sourceKeyGet, ''), concat('/(sourceKey)/', $sourceKeyGet)), cond($localeGet, concat('/(locale)/', $localeGet)))|ezurl()} title="Display {$choose1} elements per page.">{$choose1}</a>
    </li>
    <li{if eq($limit, $choose2)} class="active"{/if}>
        <a href={concat('translate/',$view , '/(limit)/', $choose2, cond(ne($sourceKeyGet, ''), concat('/(sourceKey)/', $sourceKeyGet)), cond($localeGet, concat('/(locale)/', $localeGet)))|ezurl()} title="Display {$choose2} elements per page.">{$choose2}</a>
    </li>
    <li{if eq($limit, $choose3)} class="active"{/if}>
        <a href={concat('translate/',$view , '/(limit)/', $choose3, cond(ne($sourceKeyGet, ''), concat('/(sourceKey)/', $sourceKeyGet)), cond($localeGet, concat('/(locale)/', $localeGet)))|ezurl()} title="Display {$choose3} elements per page.">{$choose3}</a>
    </li>
</ul>
</div>

{undef}
