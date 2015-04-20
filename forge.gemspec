lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'forge'

Gem::Specification.new do |gem|
  gem.name = "forge"
  gem.version = Forge::VERSION
  gem.platform = Gem::Platform::RUBY
  gem.authors = ["Kareem Gan"]
  gem.email = ["kareemgan@gmail.com"]
  gem.summary = "Data generator gem for aiding in development and testing for applications."
  gem.homepage = "https://github.com/magicalbanana"
  gem.license = ['MIT']

  gem.description = <<-EOT
   Data generation using yml files from different sources. This was originally forked from faker and ffaker gem
   respecetively.
  EOT

  gem.required_ruby_version = '>= 1.9.3'

  gem.bindir = 'bin'
  gem.executables << 'forge-console'

  gem.extra_rdoc_files = ['README.md']
  gem.post_install_message = "To test out the generator execute command forge-console"

  gem.require_path = 'lib'
  gem.files         = `git ls-files -- lib/*`.split("\n") 
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.add_runtime_dependency 'pry', '~> 0.10.1', '>= 0.10.1'
end
