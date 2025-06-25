require "bundler/gem_tasks"
require "rake/testtask"

desc "Run tests"
task :test do
  # Avoid possible test failures with the zlib applying the following patch on
  # s390x CPU architecture.
  # https://github.com/madler/zlib/pull/410
  ENV["DFLTCC"] = "0" if RUBY_PLATFORM =~ /s390x/
  Rake::Task["test_internal"].invoke
end

Rake::TestTask.new(:test_internal) do |t|
  t.libs << "test/lib"
  t.libs << "ext/java/lib" if RUBY_ENGINE == "jruby"
  t.ruby_opts << "-rhelper"
  t.test_files = FileList["test/**/test_*.rb"]
end

if RUBY_PLATFORM =~ /java/
  require 'rake/javaextensiontask'
  Rake::JavaExtensionTask.new("zlib") do |ext|
    require 'maven/ruby/maven'
    # force load of versions to overwrite constants with values from repo.
    load './ext/java/lib/zlib/versions.rb'
    # uses Mavenfile to write classpath into pkg/classpath
    # and tell maven via system properties the snakeyaml version
    # this is basically the same as running from the commandline:
    # rmvn dependency:build-classpath -Dsnakeyaml.version='use version from Psych::DEFAULT_SNAKEYAML_VERSION here'
    Maven::Ruby::Maven.new.exec('dependency:build-classpath', '-Dverbose=true')
    ext.source_version = '21'
    ext.target_version = '21'
    ext.classpath = File.read('pkg/classpath')
    ext.ext_dir = 'ext/java'
    ext.lib_dir = 'ext/java/lib'
  end
else
  require 'rake/extensiontask'
  Rake::ExtensionTask.new("zlib")
end

task :default => [:compile, :test]
