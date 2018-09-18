lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paghiper/version'

Gem::Specification.new do |spec|
  spec.name = 'paghiper'
  spec.version = Paghiper::VERSION
  spec.authors = ['Coyô Software']
  spec.email = ['ti@coyo.com.br']

  spec.summary = 'Gem para integração com a API de geração de boleto do PAGHIPER'
  spec.description = 'Gem para integração com a API de geração de boleto do PAGHIPER'
  spec.homepage = 'https://github.com/coyosoftware/paghiper'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.16'
  spec.add_development_dependency 'webmock', '~> 3.4'

  spec.add_dependency 'httparty', '>= 0.14'
  spec.add_dependency 'activesupport', '>= 3.0'
end
