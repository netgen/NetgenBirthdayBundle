INSTALLATION

- enable the bundle in registerBundles() of ezpublish/EzPublishKernel.php by adding:

    new Netgen\SimpleContentStorageBundle\NetgenSimpleContentStorageBundle(),

- in ezpublish/config/parameters.yml add 2 layout templates
parameters:
    ezpublish_legacy.default.view_default_layout: 'NetgenSimpleContentStorageBundle::pagelayout.html.twig'
    ezpublish_legacy.default.module_default_layout: 'NetgenSimpleContentStorageBundle::pagelayout_module.html.twig'

- in ezpublish/config/routing.yml add the route:
netgen_simple_content_storage:
    resource: "@NetgenSimpleContentStorageBundle/Resources/config/routing.yml"
    prefix:   /

- in administration add "Create New List" class group

- install classes form Installation/ngscs-classes

- in ezpublish/config/config.yml add in assetic section (might be unnecessary):
assetic:
    bundles:        [ NetgenSimpleContentStorageBundle ]


After git clone:
1. mv netgensimplecontentstoragebundle SimpleContentStorageBundle
2. cd ../../ezpublish_legacy/extension/
3. ln -s ../../src/Netgen/netgensimplecontentstoragebundle/Resources/ezpublish_legacy/extension/ngscs/
4. Clear cache - php ezpublish/console cache:clear
5. Generate assets - php ezpublish/console assets:install
6. Change SiteDesign from ezdemo to scs in ezpublish_legacy/settings/[siteaccess]/site.ini.append.php
