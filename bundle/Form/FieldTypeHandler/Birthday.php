<?php

declare(strict_types=1);

namespace Netgen\Bundle\BirthdayBundle\Form\FieldTypeHandler;

use DateTimeInterface;
use Ibexa\Contracts\Core\Repository\Values\Content\Content;
use Ibexa\Contracts\Core\Repository\Values\ContentType\FieldDefinition;
use Ibexa\Contracts\Core\FieldType\Value;
use Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday as BirthdayValue;
use Netgen\Bundle\EzFormsBundle\Form\FieldTypeHandler;
use Symfony\Component\Form\Extension\Core\Type\BirthdayType;
use Symfony\Component\Form\FormBuilderInterface;
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
            BirthdayType::class,
            $options
        );
    }
}
