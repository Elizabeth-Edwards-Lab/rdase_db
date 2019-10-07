# Include third party javascript
2.2.1 Search Paths
When a file is referenced from a manifest or a helper, Sprockets searches the three default asset locations for it.

The default locations are: the images, javascripts and stylesheets directories under the app/assets folder, but these subdirectories are not special - any path under assets/* will be searched.

For example, these files:

```
app/assets/javascripts/home.js
lib/assets/javascripts/moovinator.js
vendor/assets/javascripts/slider.js
vendor/assets/somepackage/phonebox.js
```
would be referenced in a manifest like this:

```
//= require home
//= require moovinator
//= require slider
//= require phonebox
```
Assets inside subdirectories can also be accessed.
```
app/assets/javascripts/sub/something.js
```
is referenced as:
```
//= require sub/something
```
You can view the search path by inspecting Rails.application.config.assets.paths in the Rails console.