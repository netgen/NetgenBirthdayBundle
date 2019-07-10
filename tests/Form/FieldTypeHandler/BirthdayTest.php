<?php

declare(strict_types=1);

namespace Netgen\Bundle\BirthdayBundle\Tests\Form\FieldTypeHandler;

use DateTimeImmutable;
use eZ\Publish\Core\Repository\Values\ContentType\FieldDefinition;
use Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value;
use Netgen\Bundle\BirthdayBundle\Form\FieldTypeHandler\Birthday;
use Netgen\Bundle\EzFormsBundle\Form\FieldTypeHandler;
use PHPUnit\Framework\TestCase;
use Symfony\Component\Form\FormBuilderInterface;

class BirthdayTest extends TestCase
{
    /**
     * @var Birthday
     */
    protected $handler;

    protected function setUp(): void
    {
        $this->handler = new Birthday();
    }

    public function testInstanceOfFieldTypeHandler(): void
    {
        self::assertInstanceOf(FieldTypeHandler::class, $this->handler);
    }

    public function testConvertFieldValueToForm(): void
    {
        $dt = new DateTimeImmutable();
        $value = new Value($dt->setTime(0, 0));

        $returnedValue = $this->handler->convertFieldValueToForm($value);

        self::assertSame($value->date->format('Y-m-d'), $returnedValue->format('Y-m-d'));
    }

    public function testConvertFieldValueFromForm(): void
    {
        $dt = new DateTimeImmutable();
        $value = new Value($dt);

        $returnedValue = $this->handler->convertFieldValueFromForm($dt);

        self::assertSame((string) $value, (string) $returnedValue);
    }

    public function testConvertFieldValueFromFormWithDataNull(): void
    {
        $value = new Value();

        $returnedValue = $this->handler->convertFieldValueFromForm(null);

        self::assertSame((string) $value, (string) $returnedValue);
    }

    public function testBuildForm(): void
    {
        $formBuilder = $this->getMockBuilder(FormBuilderInterface::class)
            ->disableOriginalConstructor()
            ->getMock();

        $formBuilder->expects(self::once())
            ->method('add');

        $fieldDefinition = new FieldDefinition(
            [
                'id' => 'id',
                'identifier' => 'identifier',
                'isRequired' => true,
                'descriptions' => ['fre-FR' => 'fre-FR'],
                'names' => ['fre-FR' => 'fre-FR'],
                'fieldSettings' => [
                    'options' => [
                        [
                            'identifier' => 'identifier0',
                            'name' => 'Identifier0',
                        ],
                        [
                            'identifier' => 'identifier1',
                            'name' => 'Identifier1',
                        ],
                    ],
                ],
            ]
        );

        $languageCode = 'eng-GB';

        $this->handler->buildFieldCreateForm($formBuilder, $fieldDefinition, $languageCode);
    }
}
