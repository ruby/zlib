# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = "zlib"
  spec.version       = "0.0.1"
  spec.authors       = ["SHIBATA Hiroshi"]
  spec.email         = ["hsbt@ruby-lang.org"]

  spec.summary       = %q{}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/ruby/zlib"
  spec.license       = "BSD-2-Clause"

  spec.files         = [".gitignore", ".travis.yml", "Gemfile", "LICENSE.txt", "README.md", "Rakefile", "bin/console", "bin/setup", "ext/zlib/extconf.rb", "ext/zlib/zlib.c", "zlib.gemspec"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions    = "ext/zlib/extconf.rb"
  spec.required_ruby_version = ">= 2.5.0dev"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rake-compiler"
end
