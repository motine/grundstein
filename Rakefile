require "bundler/gem_tasks"
require "rdoc/task"
require 'sdoc'

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError => _
  STDERR.puts "Rubocop rake tasks not added, because gem not available." # you can remove this note if you want
end

Rake::RDocTask.new do |rdoc| # options are documented here: http://ruby-doc.org/stdlib-2.0.0/libdoc/rdoc/rdoc/RDoc/Task.html
  rdoc.rdoc_dir = 'doc/api'
  rdoc.generator = 'sdoc'
  rdoc.markup = 'markdown'
  rdoc.main = 'README.md'
  rdoc.rdoc_files.include("README.md", "bin/*", "lib/**/*.rb")
  rdoc.template = 'rails' # change default from 'sdoc' to 'rails' style
  # rdoc.options.push('--quiet') # see more options here: http://ruby-doc.org/stdlib-2.0.0/libdoc/rdoc/rdoc/RDoc/Options.html
end
