# RestrictedAccess

An access rights management tool intended to work with [Devise](https://github.com/plataformatec/devise)

## Installation

Add this line to your application's Gemfile:

    gem 'restricted_access', git: 'https://github.com/4nt1/restricted_access'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install restricted_access

## Usage

The gem is currently working only with Mongoid & Devise.
You need to add the "mongoid-enum" gem to your gemfile, and include the module in the concerned model.

Generate this initializer with
```
rails g restricted_access:install model_name --levels=level1 level2 level3 --controller_scope=your_scope
```

model_name is the name of the model concerned with the access restriction.
Give the available levels of access to the --levels options
Give your controllers scope name to the --controller_scope options (default: nil)

## Contributing

1. Fork it ( http://github.com/<my-github-username>/restricted_access/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
