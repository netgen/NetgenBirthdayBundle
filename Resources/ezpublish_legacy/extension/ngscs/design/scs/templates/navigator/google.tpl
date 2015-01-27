{default
  page_uri_suffix=false()
  left_max=7
	right_max=6
	offset_num=0
  name=ViewParameter
  page_uri_suffix=false()
  left_max=$left_max
  right_max=$right_max}

	{if $offset_num|eq(2)}
		{def $off = is_set($view_parameters.offset2)|choose(0,$view_parameters.offset2)
		$off_text='offset2'}
	{elseif $offset_num|eq(3)}
		{def $off = is_set($view_parameters.offset3)|choose(0,$view_parameters.offset3)
		$off_text='offset3'}
	{elseif $offset_num|eq(4)}
		{def $off = is_set($view_parameters.offset4)|choose(0,$view_parameters.offset4)
		$off_text='offset4'}
	{elseif $offset_num|eq(5)}
		{def $off = is_set($view_parameters.offset5)|choose(0,$view_parameters.offset5)
		$off_text='offset5'}
	{else}
		{def $off = $view_parameters.offset
		$off_text='offset'}
	{/if}

{let page_count=int( ceil( div( $item_count,$item_limit ) ) )

      current_page=min($:page_count,
                       int( ceil( div( first_set( $off, 0 ),
                                       $item_limit ) ) ) )

      item_previous=sub( mul( $:current_page, $item_limit ),
                         $item_limit )
      item_next=sum( mul( $:current_page, $item_limit ),
                     $item_limit )

      left_length=min($ViewParameter:current_page,$:left_max)
      right_length=max(min(sub($ViewParameter:page_count,$ViewParameter:current_page,1),$:right_max),0)
      view_parameter_text=""
      offset_text=eq( ezini( 'ControlSettings', 'AllowUserVariables', 'template.ini' ), 'true' )|choose( concat('/',$off_text,'/'), concat('/(',$off_text,')/') )}
{* Create view parameter text with the exception of offset *}
{section loop=$view_parameters}
 {section-exclude match=or($:key|begins_with('offset'),$:item|not)}
 {set view_parameter_text=concat($:view_parameter_text,'/(',$:key,')/',$:item)}
{/section}


{section show=$:page_count|gt(1)}
  <ul class="pagination">
    {if $:item_previous|ge(0)}
      <li class="previous"><a href={concat($page_uri,$:item_previous|gt(0)|choose('',concat($:offset_text,$:item_previous)),$:view_parameter_text,$page_uri_suffix)|ezurl}>
        &laquo;&nbsp;{"Previous"|i18n("dms/navigator")}</a></li>
    {/if}


    {section show=$:current_page|gt($:left_max)}
      <li><a href={concat($page_uri,$:view_parameter_text,$page_uri_suffix)|ezurl}>1</a></li>
      {section show=sub($:current_page,$:left_length)|gt(1)}
      <li><a href="#">...</a></li>
      {/section}
    {/section}

        {section loop=$:left_length}
            {let page_offset=sum(sub($ViewParameter:current_page,$ViewParameter:left_length),$:index)}
              <li class="other"><a href={concat($page_uri,$:page_offset|gt(0)|choose('',concat($:offset_text,mul($:page_offset,$item_limit))),$ViewParameter:view_parameter_text,$page_uri_suffix)|ezurl}>{$:page_offset|inc}</a></li>
            {/let}
        {/section}

            <li class="active"><a href="#">{$:current_page|inc}</a></li>

        {section loop=$:right_length}
            {let page_offset=sum($ViewParameter:current_page,1,$:index)}
              <li class="other"><a href={concat($page_uri,$:page_offset|gt(0)|choose('',concat($:offset_text,mul($:page_offset,$item_limit))),$ViewParameter:view_parameter_text,$page_uri_suffix)|ezurl}>{$:page_offset|inc}</a></li>
            {/let}
        {/section}

    {section show=$:page_count|gt(sum($:current_page,$:right_max,1))}
      {section show=sum($:current_page,$:right_max,2)|lt($:page_count)}
        <li class="other"><li><a href="#">...</a></li>
      {/section}
      <li class="other"><a href={concat($page_uri,$:page_count|dec|gt(0)|choose('',concat($:offset_text,mul($:page_count|dec,$item_limit))),$:view_parameter_text,$page_uri_suffix)|ezurl}>{$:page_count}</a></li>
    {/section}

    {if $:item_next|lt($item_count)}
      <li class="next"><a href={concat($page_uri,$:offset_text,$:item_next,$:view_parameter_text,$page_uri_suffix)|ezurl}>{"Next"|i18n("dms/navigator")}&nbsp;&raquo;</a></li>
    {/if}
  </ul>

{/section}

 {/let}

{/default}
