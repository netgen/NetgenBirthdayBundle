<?php

namespace Netgen\BirthdayBundle\Form\FieldTypeHandler;

use NetgenOsijek\ManageContentBundle\Form\FieldTypeHandler;
use Symfony\Component\Form\FormBuilderInterface;
use eZ\Publish\API\Repository\Values\Content\Content;
use eZ\Publish\API\Repository\Values\ContentType\FieldDefinition;
use eZ\Publish\SPI\FieldType\Value;
use Symfony\Component\Validator\Constraints;

/**
 * Class Birthday
 * @package Netgen\BirthdayBundle\Form\FieldTypeHandler
 */
class Birthday extends FieldTypeHandler
{
    /**
     * {@inheritdoc}
     *
     * @param \Netgen\BirthdayBundle\Core\FieldType\Birthday\Value $value
     */
    public function convertFieldValueToForm( Value $value )
    {
        return $value->date;
    }

    /**
     * {@inheritdoc}
     */
    protected function buildFieldForm(
        FormBuilderInterface $formBuilder,
        FieldDefinition $fieldDefinition,
        $languageCode,
        Content $content = null
    )
    {
        $options = $this->getDefaultFieldOptions( $fieldDefinition, $languageCode, $content );

        $formBuilder->add( $fieldDefinition->identifier, "birthday", $options );
    }
}
