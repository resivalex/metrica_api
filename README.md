# Ruby client for Yandex Metrica API

[![Build Status](https://travis-ci.org/resivalex/metrica_api.svg?branch=master)](https://travis-ci.org/resivalex/metrica_api) [![Maintainability](https://api.codeclimate.com/v1/badges/7d22d20e04f9277afb35/maintainability)](https://codeclimate.com/github/resivalex/metrica_api/maintainability)

## Installation

Add this line to your application's Gemfile:

```
gem 'metrica_api', '~> 0.0.1'
```

Or install from command line:

```
$ gem install metrica_api
```

## Usage

```ruby
# You need an access token to use API
api = MetricaApi.counters(token)
api.data(field: 'goals') # => { 'counters' => [...], ... }
```

## Exceptions

```ruby
def read_counters

  MetricaApi.counters(token).data

rescue MetricaApi::RequestError, MetricaApi::ConnectionError => e

  puts e.message, e.backtrace

end
```

## Testing

```
bundle exec rspec
```

## Contributing

Create a pull-request or make an issue
