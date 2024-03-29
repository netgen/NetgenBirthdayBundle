Netgen Birthday Bundle installation instructions
================================================

Requirements
------------

* Ibexa Platform 4+

Installation steps
------------------

### Use Composer

Run the following command from your project root to install the bundle:

```bash
$ composer require netgen/birthday-bundle
```

### Activate the bundle

Activate the bundle in `config/bundles.php` file.

```php
<?php

return [
    ...,

    Netgen\Bundle\BirthdayBundle\NetgenBirthdayBundle::class => ['all' => true],

    ...
];
```

### Clear the caches

Clear Ibexa Platform caches.

```bash
php bin/console cache:clear
```

### Use the bundle

You can now load and create content with `ezbirthday` field type.
