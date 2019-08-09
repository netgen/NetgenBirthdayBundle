<?php

declare(strict_types=1);

namespace Netgen\Bundle\BirthdayBundle\Form\FieldTypeHandler;

use DateTimeInterface;
use eZ\Publish\API\Repository\Values\Content\Content;
use eZ\Publish\API\Repository\Values\ContentType\FieldDefinition;
use eZ\Publish\SPI\FieldType\Value;
use Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday as BirthdayValue;
use Netgen\Bundle\EzFormsBundle\Form\FieldTypeHandler;
use Symfony\Component\Form\Extension\Core\Type\BirthdayType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\HttpKernel\Kernel;
use Symfony\Component\Validator\Constraints as Assert;

final class Birthday extends FieldTypeHandler
{
    public function convertFieldValueToForm(Value $value, ?FieldDefinition $fieldDefinition = null): ?DateTimeInterface
    {
        return $value->date;
    }

    public function convertFieldValueFromForm($data): BirthdayValue\Value
    {
        if (empty($data)) {
            $data = null;
        }

        return new BirthdayValue\Value($data);
    }

    protected function buildFieldForm(
        FormBuilderInterface $formBuilder,
        FieldDefinition $fieldDefinition,
        string $languageCode,
        ?Content $content = null
    ): void {
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
