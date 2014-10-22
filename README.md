# RestrictedAccess

An access rights management tool.

## Installation

Add this line to your application's Gemfile:

    gem 'restricted_access', git: 'https://github.com/4nt1/restricted_access'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install restricted_access

## Usage

The gem is currently working only with Mongoid.

It depends on [Devise](https://github.com/plataformatec/devise) & [mongoid-enum](https://github.com/thetron/mongoid-enum).


Generate this initializer with
```
rails g restricted_access:install admin --levels=mini normal super --controller_scope=backoffice
```

model_name is the name of the model concerned with the access restriction.

Give the available levels of access to the --levels options

Give your controllers scope name to the --controller_scope options (default: nil)

This will generate the restricted_access.rb initializer

```ruby
RestrictedAccess.configure do |config|

  config.accesses  = [ {  level:  :mini,
                          label:  'Some description for this access level',
                          power:  0 },
                        { level: :normal,
                          label: 'Some description for this access level',
                          power: 1 },
                        { level: :super,
                          label: 'Some description for this access level',
                          power:  2}
                      ]
  config.resource = :admin
  config.controller_scope = :backoffice

end
```

You can customize the accesses with a label (optional) and define different power (the higher has more rights).

The `config.resource` and `config.controller_scope` are useful only in Rails, defining some methods in controllers and helpers (see below).

### RestrictedAccess::Model

Include the RestrictedAccess::Model module in your related model

```ruby
class Admin
  include Mongoid::Document
  include RestrictedAccess::Model

end
```

The module enhances the model with some methods and attributes.

Every model has now a :level attribute (Symbol type), by default the first defined in your initializer. You can set it like any attributes.

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
=> #<RestrictedAccess::Access:0x007fc255d36098 @level=:super, @label="", @power=2>

```

The `RestrictedAccess::Access` class include comparable, so you can do such things :

```ruby
admin.access > admin2.access
=> true

RestrictedAccess.accesses.max
=> #<RestrictedAccess::Access:0x007fc255d36098 @level=:super, @label="", @power=2>

```

Thanks to the [mongoid-enum](https://github.com/thetron/mongoid-enum) gem, some methods to check rights.

```ruby
admin.mini?
=> false

admin.super?
=> true

Admin::LEVEL
=> [:mini, :normal, :super]

# scopes
Admin.mini # => Mongoid::Criteria
Admin.super # => Mongoid::Criteria
```



## Contributing

1. Fork it ( http://github.com/<my-github-username>/restricted_access/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
