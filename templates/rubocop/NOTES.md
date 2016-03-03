Documentation & Conventions

To know where to find stuff, please see the mapping of content to files:
Overview and concept goes into README.Something.md files in the respective sub-folder (e.g. README.Scenes.md, can be found in yardoc's File List) <!-- This naming will be recognized by yardoc (not overwriting the top level readme) and by Gitlab (directly showing the Readme when entering the folder)-->
Programatic usage, problems, limitations goes above class or method
Implementation and algorithmic notes should be added inline
We are using this style guide. To enforce this we use Rubocop. Please run rake rubocop before submitting code. Consider using rake rubocop:auto_correct to correct all issues. If you want to correct only a single offense type use: rubocop --only Style/TrailingBlankLines --auto-correct. If you are a hundred percent sure you are doing the right thing, you can disable the issue inline (e.g. ...issue... # rubocop:disable Metrics/ClassLength)

When running the cops, it will show a link where you can get more information:

In your code you sometimes may want to disable some cops. Either
- disable them for a particular line/method/class with: `# rubocop:disable Metrics/LineLength, Style/StringLiterals`
- or disable rubocop for the full file: `# rubocop:disable all`
`rubocop --auto-gen-config`


Rakefile:

```
begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError => _
  STDERR.puts "Rubocop rake tasks not added, because gem not available." # you can remove this note if you want
end
```


Gitlab CI

unit_tests_and_code_style:
  script: # touch /tmp/asd'
    - bundle exec rake test:unit
    - bundle exec rubocop

Gemfile:

```
group :development do # optional
  gem 'yard', '~> 0.8.7.6' # documentation
  gem 'rubocop', require: false
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-byebug'
  gem 'minitest', '~> 5.6.1' # test framework
  gem 'minitest-reporters', '~> 1.0.14' # make the tests colorful
end
```