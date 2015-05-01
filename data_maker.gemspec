lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'data_maker'

Gem::Specification.new do |gem|
  gem.name = 'data_maker'
  gem.version = DataMaker::VERSION
  gem.platform = Gem::Platform::RUBY
  gem.authors = 'Kareem Gan'
  gem.email = 'kareemgan@gmail.com'
  gem.summary = 'Data generator gem for aiding in development and testing for applications.'
  gem.homepage = 'https://github.com/magicalbanana/data_maker'
  gem.license = 'MIT'

  gem.description = <<-EOT
   Data generation using yml files from different sources. This was originally forked from faker and ffaker gem
   respecetively.
  EOT

  gem.extra_rdoc_files = ['README.md']
  # gem.bindir = 'bin'
  # gem.executables << 'data_maker-console'

  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'coveralls'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'pry-byebug'
  gem.add_development_dependency 'pry-rescue'
  gem.add_development_dependency 'pry-stack_explorer'
  gem.add_development_dependency 'phonelib'

  gem.add_runtime_dependency 'pry'

  gem.post_install_message = "To test out the generator execute command data_maker-console"

  gem.required_ruby_version = '>= 1.9.3'

  gem.require_path = 'lib'
  gem.test_files   = `git ls-files -- {test,spec,features}/*`.split("\n")

  # = MANIFEST =
  gem.files = %w[
    Gemfile
    LICENSE
    README.md
    Rakefile
    data_maker.gemspec
    lib/data_maker.rb
    lib/data_maker/china/address.rb
    lib/data_maker/china/name.rb
    lib/data_maker/china/phone_number.rb
    lib/data_maker/data/china/name/first_names
    lib/data_maker/data/china/name/last_names
    lib/data_maker/data/china/phone_number/landline_phone_prefixes
    lib/data_maker/data/china/phone_number/mobile_phone_prefixes
    lib/data_maker/utilities/array_utilities.rb
    lib/data_maker/utilities/module_utilities.rb
    lib/data_maker/validators/chinese_characters.rb
    lib/data_maker/validators/chinese_phone_number.rb
    spec/lib/data_maker/china/name_spec.rb
    spec/lib/data_maker/china/phone_number_spec.rb
    spec/lib/data_maker/data_maker_spec.rb
    spec/lib/data_maker/support/matchers/phone_number_matcher.rb
    spec/lib/data_maker/utilities/array_utilities_spec.rb
    spec/lib/data_maker/utilities/module_utilities_spec.rb
    spec/spec_helper.rb
  ]
  # = MANIFEST =
end
