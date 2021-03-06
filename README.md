# Lookout::Rack::Utils

Assorted Rack utils.

## Installation

Add this line to your application's Gemfile:

    gem 'lookout-rack-utils'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lookout-rack-utils

## Usage
  Require pieces of this in your project as needed; details below.

### Lookout::Rack::Utils::Graphite
  You'll need configatron set up:

  ```ruby
  configatron.statsd do |s|
    s.prefix = 'app'
    s.host = 'localhost'
    s.port = 8125
  end
  ```
### Lookout::Rack::Utils::I18n
  You'll need configatron set up:

 ```ruby
    configatron.default_locale = :en
    configatron.locales = [:en]
 ```

  You'll also need to set the load path somewhere in your
app:
  ```ruby
  I18n.load_path = Dir["./config/locales/**/*.yml"]
  ```

  Note that we expect `t(*args)` to be called in the context of a request.

### Lookout::Rack::Utils::Log
  You'll need configatron set up.  If `Lookout::Rack::Utils::Graphite` is
present, it will increment those stats whenever a log is written.

  ```ruby
  configatron.project_name = 'My project name'
  configatron.logging do |l|
    l.enabled = true
    l.level = 'WARN'
    l.file = 'log/some_file.log'
  end
  ```

### Lookout::Rack::Utils::Request
  `Lookout::Rack::Utils::Request` will log errors using
`Lookout::Rack::Utils::Log` if it has been required elsewhere.

### Lookout::Rack::Utils::Subroute
  `subroute!(relative_path)` will fire off a request to the specified relative
path; the result can then be used, or just returned immediately to the browser.

  Examples (Used in a Sinatra application):
  ```ruby
  require 'lookout/rack/utils/subroute'
  include Lookout::Rack::Utils::Subroute

  # Return the status of a request to /api/public/v1/original_route and throw
  # away the response body
  get '/status' do
    sub_status, sub_data = subroute!('/api/public/v1/original_route')

    halt sub_status
  end

  # Assuming we have a method 'current_user', make /api/public/v1/user route
  # to the current user
  get '/api/public/v1/user' do
    subroute!("/api/public/v1/user/#{current_user.id}")
  end

  # Same as above, but a POST request - the verb and all other parts of the
  # request's env will be preserved
  post '/api/public/v1/user' do
    subroute!("/api/public/v1/user/#{current_user.id}")
  end
  ```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
