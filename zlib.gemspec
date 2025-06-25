# coding: utf-8
# frozen_string_literal: true

source_version = ["", "ext/zlib/"].find do |dir|
  begin
    break File.open(File.join(__dir__, "#{dir}zlib.c")) {|f|
      f.gets("\n#define RUBY_ZLIB_VERSION ")
      f.gets[/\s*"(.+)"/, 1]
    }
  rescue Errno::ENOENT
  end
end

version_module = Module.new do
  version_rb = File.join(__dir__, "ext/java/lib/zlib/versions.rb")
  module_eval(File.read(version_rb), version_rb)
end

Gem::Specification.new do |spec|
  spec.name          = "zlib"
  spec.version       = source_version
  spec.authors       = ["Yukihiro Matsumoto", "UENO Katsuhiro"]
  spec.email         = ["matz@ruby-lang.org", nil]

  spec.summary       = %q{Ruby interface for the zlib compression/decompression library}
  spec.description   = %q{Ruby interface for the zlib compression/decompression library}
  spec.homepage      = "https://github.com/ruby/zlib"
  spec.licenses       = ["Ruby", "BSD-2-Clause"]

  spec.files         = ["COPYING", "BSDL", "README.md", "zlib.gemspec"]
  spec.bindir        = "exe"
  spec.executables   = []
  if RUBY_ENGINE == 'jruby'
    spec.platform = 'java'
    spec.files.concat %w[
                          ext/java/org/jruby/ext/zlib/JZlibDeflate.java
                          ext/java/org/jruby/ext/zlib/JZlibInflate.java
                          ext/java/org/jruby/ext/zlib/JZlibRubyGzipReader.java
                          ext/java/org/jruby/ext/zlib/JZlibRubyGzipWriter.java
                          ext/java/org/jruby/ext/zlib/RubyGzipFile.java
                          ext/java/org/jruby/ext/zlib/RubyZlib.java
                          ext/java/org/jruby/ext/zlib/Zlib.java
                          ext/java/org/jruby/ext/zlib/ZlibLibrary.java
                          ext/java/org/jruby/ext/zlib/ZStream.java
                          ext/java/lib/zlib.rb
                          ext/java/lib/zlib.jar
                          ext/java/lib/zlib/versions.rb
                        ]
    spec.require_paths = ["ext/java/lib"]
    spec.requirements = "jar org.jruby:jzlib, #{version_module::Zlib::JZLIB_VERSION}"
    spec.add_dependency "jar-dependencies", ">= 0.1.7"
  else
    spec.files.concat ["ext/zlib/extconf.rb", "ext/zlib/zlib.c"]
    spec.require_paths = ["lib"]
    spec.extensions    = "ext/zlib/extconf.rb"
  end
  spec.required_ruby_version = ">= 2.5.0"
end
