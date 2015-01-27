<?php

class ezjscNgRgmServerFunctionsJs extends ezjscServerFunctionsJs
{
	/** THIS IS C/P FROM ezjscServerFunctionsJs.php becaus we need data map in response
     * Returns search results based on given post params
     *
     * @param mixed $args Only used if post parameter is not set
     *              0 => SearchStr
     *              1 => SearchOffset
     *              2 => SearchLimit (10 by default, max 50)
     * @return array
     */
    public static function search( $args )
    {
        $http = eZHTTPTool::instance();

        if ( $http->hasPostVariable( 'SearchStr' ) )
            $searchStr = trim( $http->postVariable( 'SearchStr' ) );
        else if ( isset( $args[0] ) )
            $searchStr = trim( $args[0] );

        if ( $http->hasPostVariable( 'SearchOffset' ))
            $searchOffset = (int) $http->postVariable( 'SearchOffset' );
        else if ( isset( $args[1] ) )
            $searchOffset = (int) $args[1];
        else
            $searchOffset = 0;

        if ( $http->hasPostVariable( 'SearchLimit' ))
            $searchLimit = (int) $http->postVariable( 'SearchLimit' );
        else if ( isset( $args[2] ) )
            $searchLimit = (int) $args[2];
        else
            $searchLimit = 10;

        // Do not allow to search for more then x items at a time
        $ini = eZINI::instance();
        $maximumSearchLimit = (int) $ini->variable( 'SearchSettings', 'MaximumSearchLimit' );
        if ( $searchLimit > $maximumSearchLimit )
            $searchLimit = $maximumSearchLimit;

        // Prepare node encoding parameters
        $encodeParams = array();
        if ( self::hasPostValue( $http, 'EncodingLoadImages' ) )
            $encodeParams['loadImages'] = true;

        if ( self::hasPostValue( $http, 'EncodingFetchChildrenCount' ) )
            $encodeParams['fetchChildrenCount'] = true;

        if ( self::hasPostValue( $http, 'EncodingFetchSection' ) )
            $encodeParams['fetchSection'] = true;

        if ( self::hasPostValue( $http, 'EncodingFormatDate' ) )
            $encodeParams['formatDate'] = $http->postVariable( 'EncodingFormatDate' );

        if ( self::hasPostValue( $http, 'DataMap' ) )
            $encodeParams['dataMap'] = $http->postVariable( 'DataMap' );

        if ( self::hasPostValue( $http, 'DataMapType' ) )
            $encodeParams['dataMapType'] = $http->postVariable( 'DataMapType' );

        // Prepare search parameters
        $params = array( 'SearchOffset' => $searchOffset,
                         'SearchLimit' => $searchLimit,
                         'SortArray' => array( 'published', 0 ), // Legacy search engine uses SortArray
                         'SortBy' => array( 'published' => 'desc' ) // eZ Find search method implementation uses SortBy
        );

        if ( self::hasPostValue( $http, 'SearchContentClassAttributeID' ) )
        {
             $params['SearchContentClassAttributeID'] = self::makePostArray( $http, 'SearchContentClassAttributeID' );
        }
        else if ( self::hasPostValue( $http, 'SearchContentClassID' ) )
        {
             $params['SearchContentClassID'] = self::makePostArray( $http, 'SearchContentClassID' );
        }
        else if ( self::hasPostValue( $http, 'SearchContentClassIdentifier' ) )
        {
             $params['SearchContentClassID'] = eZContentClass::classIDByIdentifier( self::makePostArray( $http, 'SearchContentClassIdentifier' ) );
        }

        if ( self::hasPostValue( $http, 'SearchSubTreeArray' ) )
        {
             $params['SearchSubTreeArray'] = self::makePostArray( $http, 'SearchSubTreeArray' );
        }

        if ( self::hasPostValue( $http, 'SearchSectionID' ) )
        {
             $params['SearchSectionID'] = self::makePostArray( $http, 'SearchSectionID' );
        }

        if ( self::hasPostValue( $http, 'SearchDate' ) )
        {
             $params['SearchDate'] = (int) $http->postVariable( 'SearchDate' );
        }
        else if ( self::hasPostValue( $http, 'SearchTimestamp' ) )
        {
            $params['SearchTimestamp'] = self::makePostArray( $http, 'SearchTimestamp' );
            if ( !isset( $params['SearchTimestamp'][1] ) )
                $params['SearchTimestamp'] = $params['SearchTimestamp'][0];
        }

        if ( self::hasPostValue( $http, 'EnableSpellCheck' ) || self::hasPostValue( $http, 'enable-spellcheck', '0' ) )
        {
            $params['SpellCheck'] = array( true );
        }

        if ( self::hasPostValue( $http, 'GetFacets' ) || self::hasPostValue( $http, 'show-facets', '0' ) )
        {
            $params['facet'] = eZFunctionHandler::execute( 'ezfind', 'getDefaultSearchFacets', array() );
        }

        $result = array( 'SearchOffset' => $searchOffset,
                         'SearchLimit' => $searchLimit,
                         'SearchResultCount' => 0,
                         'SearchCount' => 0,
                         'SearchResult' => array(),
                         'SearchString' => $searchStr,
                         'SearchExtras' => array()
        );

        // Possibility to keep track of callback reference for use in js callback function
        if ( $http->hasPostVariable( 'CallbackID' ) )
            $result['CallbackID'] = $http->postVariable( 'CallbackID' );

        // Only search if there is something to search for
        if ( $searchStr )
        {
            $searchList = eZSearch::search( $searchStr, $params );

            $result['SearchResultCount'] = $searchList['SearchResult'] !== false ? count( $searchList['SearchResult'] ) : 0;
            $result['SearchCount'] = (int) $searchList['SearchCount'];
            $result['SearchResult'] = ezjscAjaxContent::nodeEncode( $searchList['SearchResult'], $encodeParams, false );

            // ezfind stuff
            if ( isset( $searchList['SearchExtras'] ) && $searchList['SearchExtras'] instanceof ezfSearchResultInfo )
            {
                if ( isset( $params['SpellCheck'] ) )
                    $result['SearchExtras']['spellcheck'] = $searchList['SearchExtras']->attribute( 'spellcheck' );


                if ( isset( $params['facet'] ) )
                {
                    $facetInfo = array();
                    $retrievedFacets = $searchList['SearchExtras']->attribute( 'facet_fields' );
                    $baseSearchUrl = "/content/search/";
                    eZURI::transformURI( $baseSearchUrl, false, 'full' );

                    foreach ( $params['facet'] as $key => $defaultFacet )
                    {
                        $facetData       = $retrievedFacets[$key];
                        $facetInfo[$key] = array( 'name' => $defaultFacet['name'], 'list' => array() );
                        if ( $facetData !== null )
                        {
                            foreach ( $facetData['nameList'] as $key2 => $facetName )
                            {
                                if ( $key2 != '' )
                                {
                                    $tmp = array( 'value' => $facetName );
                                    $tmp['url'] = $baseSearchUrl . '?SearchText=' . $searchStr . '&filter[]=' . $facetData['queryLimit'][$key2] . '&activeFacets[' . $defaultFacet['field'] . ':' . $defaultFacet['name'] . ']=' . $facetName;
                                    $tmp['count'] = $facetData['countList'][$key2];
                                    $facetInfo[$key]['list'][] = $tmp;
                                }
                            }
                        }
                    }
                    $result['SearchExtras']['facets'] = $facetInfo;
                }
            }//$searchList['SearchExtras'] instanceof ezfSearchResultInfo
        }// $searchStr

        return $result;
    }
}

?>
