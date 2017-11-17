Gem::Specification.new do |gem|
  gem.authors       = ['albertldlan','JaredShay']
  gem.email         = ['albertldlan@gmail.com','Jared.Shay@gmail.com']
  gem.description   = %q{Ruby implemention of https://github.com/paulgb/simplediff.}
  gem.summary       = %q{Ruby implemention of https://github.com/paulgb/simplediff.}
  gem.homepage      = 'https://github.com/albertldlan/simplediff-ruby'

  gem.files         = %w{lib/simplediff-ruby.rb README.md}
  gem.test_files    = `git ls-files -- test/*`.split("\n")
  gem.name          = 'simplediff-ruby'
  gem.require_paths = ['lib']
  gem.version       = '1.0.0'
  gem.license       = 'zlib-acknowledgement'

  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'minitest-reporters'
end