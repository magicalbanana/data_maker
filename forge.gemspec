lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'forge'

Gem::Specification.new do |s|
  s.name = "forge"
  s.version = Forge::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Kareem Gan"]
  s.email = ["kareemgan@gmail.com"]
  s.summary = "Data generator gem for aiding in development and testing for applications."

  s.description = <<-EOT
   Data generation using yml files from different sources. This was originally forked from faker and ffaker gem
   respecetively.
  EOT

  s.homepage = "https://github.com/magicalbanana"
  s.bindir = 'bin'
  s.licenses = ['MIT']

  s.extra_rdoc_files = ['README.md']

  s.executables << 'forge-console'

  s.add_runtime_dependency 'pry', '~> 0.10.1', '>= 0.10.1'

  s.post_install_message = "To test out the generator execute command forge-console"

  s.required_ruby_version = '>= 1.9.3'

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
end
