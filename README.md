# RestrictedAccess

An access rights management tool.

## Installation

Add this line to your application's Gemfile:

    gem 'restricted_access'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install restricted_access

## Previous version of the README (for version 0.0.2)

can be found [here](https://github.com/4nt1/restricted_access/blob/develop/README-v0.0.2.md)

## Usage

Generate the config file with the generator, pass the resources as an argument.

```
  rails g restricted_access:install -r user admin
```

## Active Record

You have to run a migration to add the `:level` field to your model.

```
$ rails g migration AddLevelToAdmin
```
You can edit it this way :

```ruby
class AddLevelToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :level, :integer
  end
end

```

## Mongoid support

You need the `'mongoid-enum'` gem if you use mongoid.
Just ad it to your gemfile.

```
gem 'mongoid-enum'
```

I didn't ship it as a dependency as it's useless for active_record users, and I didn't want to copy/paste some nice code done by someone else.

### Models

You must define the different levels of accesses in your model.

```ruby
class Admin
  include Mongoid::Document
  access_levels mini: 0, normal: 1, super: 2
end
```

The module enhances the model with some methods and attributes.

Every model has now a :level attribute, by default the first defined by the class method.

You can set it like any attributes.

```ruby
admin = Admin.first
admin.update(level: :super)

admin2 = Admin.last
admin.update(level: :mini)
```

The level defines its access rights.

Each instance has a `:access` method, returning a `RestrictedAccess::Access` instance.

```ruby
admin.access
=> #<RestrictedAccess::Access:0x007fc255d36098 @level=:super, @power=2>

```

The `RestrictedAccess::Access` class include comparable, so you can do such things :

```ruby
admin.access > admin2.access
=> true

RestrictedAccess.accesses.max
=> #<RestrictedAccess::Access:0x007fc255d36098 @level=:super, @power=2>

```
As the `:level` attribute is an enum, you get this kind of methods :

```ruby
admin.mini?
=> false

admin.super?
=> true

# scopes
Admin.mini # =>     Mongoid::Criteria
# or
Admin.super # => => ActiveRecord::Relation
```

### Controllers

Controllers inheriting from ApplicationController have now a few more methods:

* `:prevent_#{level}_#{resource_name}_access`, which calls `:restrict_#{current_resource.level}_#{resource_name}_access` if the `:current_#{resource_name}` doesn't have enough access right.

If you use Devise, you already have a `:current_#{resource_name}` method, if you don't use Devise, just implement the method.

```ruby
class FrontController < ApplicationController
  before_action :prevent_normal_admin_access,  except: [:index]
  # mini & normal admins will only be able to access index view
end
```

* `:restrict_#{level}_#{resource_name}_access` which redirect to the `root_path`.

You can override the method in your controller to do something else.

```ruby
class FrontController < ApplicationController
  before_action :prevent_normal_admin_access,  except: [:index]
  # Some code ...

  private

    def restrict_mini_admin_access
      redirect_to some_path, notice: 'Nope dude' and return
    end

    def restrict_normal_admin_access
      redirect_to some_other_path, notice: 'Nope dude' and return
    end
end
```

You can also define a more global `:restrict_#{resource_name}_access` method which applies to all concerned resources.

```ruby
class FrontController < ApplicationController

  private
    # this method as a bigger precedency than the other one
    def restrict_admin_access
      redirect_to some_path, notice: 'Nope dude' and return
    end

    def restrict_normal_admin_access
      redirect_to some_other_path, notice: 'Nope dude' and return
    end
end
```

### Helpers

The gem provides a `:available_for` method in the views, allowing you to hide some part of the view.

```html
<!-- this div won't be seen be admins lower than super -->
<%= available_for :super, :admin do %>
  <div>
    I have something to hide here.
  </div>
<%- end %>
```




## Contributing

1. Fork it ( http://github.com/4nt1/restricted_access/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
