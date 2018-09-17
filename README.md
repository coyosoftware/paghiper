# PAGHIPER

Gem para integração com a API de geração de boleto do [PAGHIPER](https://dev.paghiper.com/)

[![Build Status](https://travis-ci.com/coyosoftware/paghiper.svg?branch=master)](https://travis-ci.com/coyosoftware/paghiper)
[![Maintainability](https://api.codeclimate.com/v1/badges/33a90218586cd93bb200/maintainability)](https://codeclimate.com/github/coyosoftware/paghiper/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/33a90218586cd93bb200/test_coverage)](https://codeclimate.com/github/coyosoftware/paghiper/test_coverage)

**Atualmente a gem suporta a versão v1.3 da API do PAGHIPER**

## Instalação

Adicione essa linha no seu Gemfile:

```ruby
gem 'paghiper'
```

e execute:

    $ bundle

Ou instale a gem via:

    $ gem install paghiper

## Configuração

Gere o arquivo de inicialização do Rails

    $ rails g paghiper:install

Configure o client

```ruby
Paghiper.configure do |config|
  config.api_key = 'apk_99999999-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
  config.http_debug = true
end
```

## Uso

### Gerando boletos

```ruby
Paghiper::Transaction.create(transaction_data)
```

Consulte os dados necessários para a geração do boleto na [documentação da API](https://dev.paghiper.com/reference#gerar-boleto) do PAGHIPER

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/coyosoftware/paghiper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Paghiper project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/coyosoftware/paghiper/blob/master/CODE_OF_CONDUCT.md).
