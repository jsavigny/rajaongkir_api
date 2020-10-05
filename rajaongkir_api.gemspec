require_relative 'lib/rajaongkir/version'

Gem::Specification.new do |spec|
  spec.name          = "rajaongkir_api"
  spec.version       = Rajaongkir::VERSION
  spec.authors       = ["Julio Savigny"]
  spec.email         = ["jsavigny@gmail.com"]

  spec.summary       = %q{Rajaongkir.com API wrapper for Ruby}
  spec.description   = %q{Rajaongkir.com API wrapper for Ruby}
  spec.homepage      = "https://rubygems.org/gems/rajaongkir_api"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/jsavigny/rajaongkir_api"
  spec.metadata["changelog_uri"] = "https://github.com/jsavigny/rajaongkir_api"

  spec.add_dependency 'faraday', '~> 1.0.0'
  spec.add_dependency 'faraday_middleware', '~> 1.0.0'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
