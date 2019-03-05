
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ipstack/version'

Gem::Specification.new do |spec|
  spec.name          = 'ipstack'
  spec.version       = Ipstack::VERSION
  spec.authors       = ['Nathan Pierce']
  spec.email         = ['connarpierce@gmail.com']

  spec.summary       = %q{Unofficial http://api.ipstack.com/ gem}
  spec.description   = %q{Unofficial http://api.ipstack.com/ gem providing methods for use in Ruby and Rails}
  spec.homepage      = 'https://github.com/NorseGaud/ipstack'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "CUSTOM GEM URL"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     'public gem pushes.'
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_runtime_dependency 'nokogiri', '>= 1.8', '< 2.0' # Ability to parse XML response


end
