<?php

declare(strict_types=1);

namespace Netgen\Bundle\BirthdayBundle\Form\FieldTypeHandler;

use eZ\Publish\API\Repository\Values\Content\Content;
use eZ\Publish\API\Repository\Values\ContentType\FieldDefinition;
use eZ\Publish\SPI\FieldType\Value;
use Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday as BirthdayValue;
use Netgen\Bundle\EzFormsBundle\Form\FieldTypeHandler;
use Symfony\Component\Form\Extension\Core\Type\BirthdayType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\HttpKernel\Kernel;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * Class Birthday.
 */
class Birthday extends FieldTypeHandler
{
    /**
     * {@inheritdoc}
     */
    public function convertFieldValueToForm(Value $value, ?FieldDefinition $fieldDefinition = null)
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

    /**
     * {@inheritdoc}
     */
    protected function buildFieldForm(
        FormBuilderInterface $formBuilder,
        FieldDefinition $fieldDefinition,
        $languageCode,
        ?Content $content = null
    ) {
        $options = $this->getDefaultFieldOptions($fieldDefinition, $languageCode, $content);

        $options['input'] = 'datetime';
        $options['widget'] = 'choice';
        $options['constraints'][] = new Assert\Date();

        $formBuilder->add(
            $fieldDefinition->identifier,
            Kernel::VERSION_ID < 20800 ? 'birthday' : BirthdayType::class,
            $options
        );
    }
}
