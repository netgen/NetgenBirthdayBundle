<?php

/**
 * @copyright Copyright (C) 1999-2012 eZ Systems AS. All rights reserved.
 * @author pb
 * @license http://www.gnu.org/licenses/gpl-2.0.txt GNU General Public License v2
 * @version 2.7.0
 * @package ezfind
 *
 */

class ezfSolrDocumentFieldeZBirthday extends ezfSolrDocumentFieldBase
{
    public static $subattributesDefinition = array( self::DEFAULT_SUBATTRIBUTE => 'int',
                                                    'month' => 'int',
                                                    'day' => 'int' );
 
 
    const DEFAULT_SUBATTRIBUTE = 'year';
 
    function __construct( eZContentObjectAttribute $attribute )
    {
        parent::__construct( $attribute );
    }


    public function getData()
    {
        $data = array();
        $contentClassAttribute = $this->ContentObjectAttribute->attribute( 'contentclass_attribute' );
        $subattributesDefinition = self::$subattributesDefinition;
        
        $dateObject = $this->ContentObjectAttribute->attribute( 'content' );

        foreach ( $subattributesDefinition as $name => $type )
        {
            $fieldName = parent::generateSubattributeFieldName( $contentClassAttribute, $name, $type );
            switch ($name)
            {
                case 'year':
                    $fieldValue = $dateObject->attribute( 'year');
                    break;
                case 'month':
                    $fieldValue = $dateObject->attribute( 'month' );
                    break;
                case 'day':
                    $fieldValue = $dateObject->attribute( 'day' );
                    break;
                default:
                    break;
            }
            $data[$fieldName] = $fieldValue;
        }

        return $data;

    }

    public static function getFieldName( eZContentClassAttribute $classAttribute, $subAttribute = null, $context = null )
    {
        if ( $subAttribute and
             $subAttribute !== '' and
             array_key_exists( $subAttribute, self::$subattributesDefinition ) and
             $subAttribute != self::DEFAULT_SUBATTRIBUTE )
        {
            return parent::generateSubattributeFieldName( $classAttribute,
                                                          $subAttribute,
                                                          self::$subattributesDefinition[$subAttribute] );
        }
        else
        {
            return parent::generateAttributeFieldName( $classAttribute,
                                                       self::$subattributesDefinition[self::DEFAULT_SUBATTRIBUTE] );
        }
    }
 
    public static function getFieldNameList( eZContentClassAttribute $classAttribute, $exclusiveTypeFilter = array() )
    {
 
        $subfields = array();
 
        //   Handle first the default subattribute
        $subattributesDefinition = self::$subattributesDefinition;
        if ( !in_array( $subattributesDefinition[self::DEFAULT_SUBATTRIBUTE], $exclusiveTypeFilter ) )
        {
            $subfields[] = parent::generateAttributeFieldName( $classAttribute, $subattributesDefinition[self::DEFAULT_SUBATTRIBUTE] );
        }
        unset( $subattributesDefinition[self::DEFAULT_SUBATTRIBUTE] );
 
        //   Then hanlde all other subattributes
        foreach ( $subattributesDefinition as $name => $type )
        {
            if ( empty( $exclusiveTypeFilter ) or !in_array( $type, $exclusiveTypeFilter ) )
            {
                $subfields[] = parent::generateSubattributeFieldName( $classAttribute, $name, $type );
            }
        }
        return $subfields;
    }
    static function getClassAttributeType( eZContentClassAttribute $classAttribute, $subAttribute = null, $context = 'search' )
    {
        if ( $subAttribute and
             $subAttribute !== '' and
             array_key_exists( $subAttribute, self::$subattributesDefinition ) )
        {
            return self::$subattributesDefinition[$subAttribute];
        }
        else
        {
            return self::$subattributesDefinition[self::DEFAULT_SUBATTRIBUTE];
        }
    }

}
?>
