<?php

namespace Netgen\Bundle\BirthdayBundle\Form\FieldTypeHandler;

use eZ\Publish\SPI\FieldType\Value;
use Netgen\Bundle\EzFormsBundle\Form\FieldTypeHandler;
use Symfony\Component\Form\FormBuilderInterface;
use eZ\Publish\API\Repository\Values\ContentType\FieldDefinition;
use eZ\Publish\API\Repository\Values\Content\Content;
use Symfony\Component\Validator\Constraints as Assert;
use Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday as BirthdayValue;

/**
 * Class Birthday.
 */
class Birthday extends FieldTypeHandler
{
    /**
     * {@inheritdoc}
     */
    protected function buildFieldForm(
        FormBuilderInterface $formBuilder,
        FieldDefinition $fieldDefinition,
        $languageCode,
        Content $content = null
    ) {
        $options = $this->getDefaultFieldOptions($fieldDefinition, $languageCode, $content);

        $options['input'] = 'datetime';
        $options['widget'] = 'choice';
        $options['constraints'][] = new Assert\Date();

        $formBuilder->add($fieldDefinition->identifier, 'birthday', $options);
    }

    /**
     * {@inheritdoc}
     */
    public function convertFieldValueToForm(Value $value, FieldDefinition $fieldDefinition = null)
    {
        return $value->date;
    }

    /**
     * {@inheritdoc}
     *
     * @return BirthdayValue\Value
     */
    public function convertFieldValueFromForm($data)
    {
        if (empty($data)) {
            $data = null;
        }

        return new BirthdayValue\Value($data);
    }
}
