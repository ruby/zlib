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
  t.ruby_opts << "-rhelper"
  t.test_files = FileList["test/**/test_*.rb"]
end

require 'rake/extensiontask'
Rake::ExtensionTask.new("zlib")

task :default => [:compile, :test]
