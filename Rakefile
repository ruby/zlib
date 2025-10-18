require "bundler/gem_tasks"
require "rake/testtask"
require "ruby-core/extensiontask"

if RUBY_PLATFORM.include?("s390x")
  # Avoid possible test failures with the zlib applying the following patch on
  # s390x CPU architecture.
  # https://github.com/madler/zlib/pull/410
  ENV["DFLTCC"] = "0"
end

extask = RubyCore::ExtensionTask.new(Bundler::GemHelper.instance.gemspec)

desc "Run tests"
Rake::TestTask.new do |t|
  t.libs << "test/lib"
  t.libs.concat(extask.libs)
  t.ruby_opts << "-rhelper"
  t.test_files = FileList["test/**/test_*.rb"]
end

task :default => [:compile, :test]
