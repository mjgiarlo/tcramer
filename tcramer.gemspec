# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'tcramer/version'

# rubocop:disable Metrics/BlockLength
# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'tcramer'
  s.version     = Tcramer::VERSION
  s.authors     = ['Michael J. Giarlo']
  s.email       = ['mjgiarlo@stanford.edu']
  s.homepage    = 'http://cramer.space/'
  s.summary     = 'tcramer writes rake tasks'
  s.description = 'tcramer writes rake tasks'
  s.license     = 'MIT'

  s.files       = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)

  s.add_dependency 'rails', '>= 4.2'
  s.add_dependency 'zalgo'

  s.add_development_dependency 'engine_cart'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'sqlite3'

  s.post_install_message = "
    tcramer is in the house!!!
          🤠
　　　　　🐧🐧🐧
　　　　🐧 　🐧　🐧
　　　👇🏽　  🐧🐧　👇🏽
　　　　　🐧　  🐧
　　　　　🐧　　🐧
　　　　　 👢　　👢
    howdy. I'm the sheriff of rake tasks.
  "
end
# rubocop:enable Metrics/BlockLength
