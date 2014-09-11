base64_attachment
=================

> Upload base64-encoded file attachments to a rails rest service

This gem allows you to define `file`-attributes on an active record class which can receive base64-encoded strings which comes in handy for json rest clients posting images to a rails application.
Simply post your base64-encoded string using the `_base64`-suffix on the attribute name.

Usage
-----

Register your model for the base64-hook
```ruby
class Post < ActiveRecord::Base
  has_attached_base64 :image
end
```

Post json
```json
{
  "post": {
    "image_base64": "base64-encoded string"
  }
}
```

The content-type as well as the original_filename is automatically generated based on magic numbers using the [mime-magic](https://github.com/minad/mimemagic)-gem.