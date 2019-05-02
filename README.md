# Madmin

Short description and motivation.

## Usage

How to use my plugin.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'madmin'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install madmin
```

Then you can run the installer to generate resources for all models in
your app that inherit from `ActiveRecord::Base` by running:

```bash
rails generate madmin:install
```

## Generating Resources

To generate (or re-generate) a Madmin dashboard for a resource, you
can run the following command and pass in the model name

```bash
rails generate madmin:install User
```

## Autoloading Lib

If you want to avoid having to restart your Rails application everytime you make an adjustment to a `lib/madmin/resources.rb`, add the following to `config/application.rb`:

```ruby
# Autoload Madmin
config.autoload_paths += Dir["#{config.root}/lib/madmin/**/"]
```

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
