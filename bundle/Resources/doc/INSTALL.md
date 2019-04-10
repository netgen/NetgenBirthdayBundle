Netgen Birthday Bundle installation instructions
================================================

Requirements
------------

* Recent version of eZ Publish 5 or eZ Platform

Installation steps
------------------

### Use Composer

Run the following command from your project root to install the bundle:

```bash
$ composer require netgen/birthday-bundle:~1.0
```

### Activate the bundle

Activate the bundle in `app/AppKernel.php` file.

```php
public function registerBundles()
{
   $bundles = array(
       new Symfony\Bundle\FrameworkBundle\FrameworkBundle(),
       ...
       new Netgen\Bundle\BirthdayBundle\NetgenBirthdayBundle()
   );

   ...
}
```

### Clear the caches

Clear eZ Publish caches.

```bash
php app/console cache:clear
```

### Use the bundle

You can now load and create content with `ezbirthday` field type.
