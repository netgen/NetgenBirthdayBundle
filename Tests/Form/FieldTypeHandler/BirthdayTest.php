<?php

namespace Netgen\Bundle\BirthdayBundle\Tests\Form\FieldTypeHandler;

use eZ\Publish\Core\Repository\Values\ContentType\FieldDefinition;
use Netgen\Bundle\BirthdayBundle\Core\FieldType\Birthday\Value;
use Netgen\Bundle\BirthdayBundle\Form\FieldTypeHandler\Birthday;
use Netgen\Bundle\EzFormsBundle\Form\FieldTypeHandler;
use Symfony\Component\Form\FormBuilder;

class BirthdayTest extends \PHPUnit_Framework_TestCase
{
    /**
     * @var Birthday
     */
    protected $handler;

    public function setUp()
    {
        $this->handler = new Birthday();
    }

    public function testInstanceOfFieldTypeHandler()
    {
        $this->assertInstanceOf(FieldTypeHandler::class, $this->handler);
    }

    public function testConvertFieldValueToForm()
    {
        $dt = new \DateTime();
        $value = new Value($dt);
        $dt->setTime(0, 0, 0);

        $returnedValue = $this->handler->convertFieldValueToForm($value);

        $this->assertEquals($dt, $returnedValue);
    }

    public function testConvertFieldValueFromForm()
    {
        $dt = new \DateTime();
        $value = new Value($dt);

        $returnedValue = $this->handler->convertFieldValueFromForm($dt);

        $this->assertEquals($value, $returnedValue);
    }

    public function testConvertFieldValueFromFormWithDataNull()
    {
        $value = new Value();

        $returnedValue = $this->handler->convertFieldValueFromForm(null);

        $this->assertEquals($value, $returnedValue);
    }

    public function testBuildForm()
    {
        $formBuilder = $this->getMockBuilder(FormBuilder::class)
            ->disableOriginalConstructor()
            ->setMethods(array('add'))
            ->getMock();

        $formBuilder->expects($this->once())
            ->method('add');

        $fieldDefinition = new FieldDefinition(
            array(
                'id' => 'id',
                'identifier' => 'identifier',
                'isRequired' => true,
                'descriptions' => array('fre-FR' => 'fre-FR'),
                'names' => array('fre-FR' => 'fre-FR'),
                'fieldSettings' => array(
                    'options' => array(
                        array(
                            'identifier' => 'identifier0',
                            'name' => 'Identifier0',
                        ),
                        array(
                            'identifier' => 'identifier1',
                            'name' => 'Identifier1',
                        ),
                    ),
                ),
            )
        );

        $languageCode = 'eng-GB';

        $this->handler->buildFieldCreateForm($formBuilder, $fieldDefinition, $languageCode);
    }
}
