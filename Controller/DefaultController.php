<?php

namespace Netgen\BirthdayBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction($name)
    {
        return $this->render('NetgenBirthdayBundle:Default:index.html.twig', array('name' => $name));
    }
}
