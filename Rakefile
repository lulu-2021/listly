require "bundler/gem_tasks"
require 'rspec/core/rake_task'
#
RSpec::Core::RakeTask.new(:spec)
# - ensure the default 'rake' runs the whole suite!
task :default => 'spec:all'
#
desc 'Run the whole test suite'
namespace :spec do
  # Or individual pieces
  namespace :select do
    RSpec::Core::RakeTask.new(:railtie) do |t|
      t.pattern = FileList["spec/railtie/*_spec.rb"]
    end
    RSpec::Core::RakeTask.new(:listly) do |t|
      t.pattern = FileList["spec/listly/*_spec.rb"]
    end
  end
  #
  task :all => ["spec:select:listly", "spec:select:railtie"]
end
