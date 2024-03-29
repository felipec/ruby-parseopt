# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = 'parseopt'
  spec.version = '0.3.2'
  spec.author = 'Felipe Contreras'
  spec.email = 'felipe.contreras@gmail.com'
  spec.summary = 'A very simple option parser.'
  spec.license = 'GPL-2.0-only'
  spec.homepage = 'https://github.com/felipec/ruby-parseopt'
  spec.files = %w[lib/parseopt.rb]
  spec.extra_rdoc_files = %w[README.md]
  spec.add_development_dependency 'rake', '~> 13'
  spec.add_development_dependency 'test-unit', '~> 3'
end
