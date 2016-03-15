# Development

## How generators work

Each generator has a directory in the `generators` folder. The generator's name is determined by the directory's name.
Directories starting with `.` or `#` are ignored. All others must have a `_generator.rb` file.
In there...

- ...must be a `def run` method.
- ...must be a `def spec` method which returns a hash with at least `{desc: '....'}`.
- ...may be a `def caveats` method which returns a string to be displayed after the generator has run.
- ...can be arbitrary other methods or declarations.

Example:

```ruby
# file: generators/fancy/_generator.rb
def run
  doc_existed = directory('doc') # ensure doc folder is there
  template('newfile') # finds `newfile` in the generator folder and copies it to the project
  template('doc/.keep') unless doc_existed # and that there is a .keep if needed
  template('probably_existing_file', assume_append: true)

  info("EXIST", "YEEY") if File.exists?(File.join(@project_path, 'yeey')) # use Ruby methods
  answer = ask("You?  ") # use HighLine methods
end

def caveats
  res = <<CAVEATS
Please run `bundle install` in your project.
CAVEATS
  return res
end

def spec
  return { desc: 'does some fancy stuff' }
end
```

### Generator context

The generator script is guaranteed to include:

- Ruby's standard methods (standard library) 
- [HighLine](https://github.com/JEG2/highline) gem (`require 'highline/import'` was run)
- [Thor](https://github.com/erikhuda/thor) gem loaded.
- The following helpers:

```ruby
@generator_path # root path of the generator e.g. `.../generators/sdoc/`
@working_path # path of the current working directory (may be != to @project_path)
@project_path # root path of the project (the folder containing the .git directory)

# Ensures that the project has the directory given.
# This method returns if the directory already existed.
def directory(relative_project_path)
end

# Processes the template found at `relative_project_path` and copies it to the project.
# Relative_template_path determines the path of the template relative to the generator's root.
# If `destination_path` is nil, the destination path will be determined by appending `relative_template_path` to `@project_path`.
# If `destination_path` is given, it may be an absolute path or a relative path (to `@project_path`).
# In case the destination file already exists, the user will be queried what to do (append, overwrite, skip or print).
# If `assume_append` is true, the user is not queried and the template will be appended.
def template(relative_template_path, destination_path: nil, assume_append: false) # rubocop:disable Metrics/CyclomaticComplexity, 
end

# Prints out a message.
def info(action, message)
end

# Sets a variable with the given `name` and `value` to be available for all future templates.
def template_context(name, value)
end
```

Please see `lib/grundstein/generator/environment.rb` for more.

## Templates

Grundstein uses [mustache](https://mustache.github.io/) as template engine.
Please see an extensive description [here](https://mustache.github.io/mustache.5.html).

There are a few variables guaranteed to be present:

- `existed?` and `new_file?` as boolean values determining if a new file has just been created.
- `project_path`, `generator_path` and `working_path`. Description, please see above
- You can also use `template_context(name, value)` in your generator's run method to add other variables.  
  (use a question mark at the end of the name for boolean values).

Example:

```ruby
def run
  template_context("rails?", agree("Do you intend to use Rails?  ")) # note the two spaces at the end
  template_context("name", ask("You name?  "))
end
# ...
```

```ruby
# Author: {{name}}

{{#new_file?}}
source 'https://rubygems.org'
{{/new_file?}}

gem 'sdoc'
{{#rails?}}
gem 'rails'
{{/rails?}}
```

## Testing

```bash
# you should test your generators in a new project
cd /tmp/
git init myproject
cd myproject/
RUBYLIB='/vagrant/lib:$RUBYLIB' USE_GEM_REPO=true bin/grundstein add rubocop # makes the gem find the right lib folder and disables the git updated repo
```

## Publishing

```bash
rm grundstein-*.gem
gem build grundstein.gemspec
gem push grundstein-*.gem
#gem install grundstein
#gem uninstall grundstein
```

## API documentation

We are using the [sdoc](https://github.com/voloko/sdoc) generator which is based on [rdoc](https://github.com/rdoc/rdoc).
You may generate the documentation via `rake rdoc` and then find it in `doc/api`.

For documenting methods and classes we use [markdown](https://daringfireball.net/projects/markdown/). Just add a comment above a class, method or attribute.
If you are not familiar with markdown, please see this [cheat sheet](http://nestacms.com/docs/creating-content/markdown-cheat-sheet).  
Here a quick example:

```ruby
# This is a mountain in the landscape.
# It has seasons and simulates weather.
class Mountain
  # The hight of the mountain [meter].
  attr_accessor :height
  
  # Constructor.
  # The `height` is measured in meters.
  # If snow is true, we can build ski lifts.
  def initialize(height, snow=false)
  end
  
  # Changes the weather on the mountain and sends a letter to the weather god.
  # `season` can be either `:summer`, `:spring`, `:fall` or `:winter`.
  # The letter to the weather god will include the desired `min_temp` or `max_temp`.
  #
  #     m = Mountain.new(1000)    # this is some example code
  #     m.change_season(:summer) 
  def change_season(season, min_temp: -10, max_temp: 30)
  end

  # Whenever rain occures, the block will be executed.
  # **WARNING**: Will be called from another thread.
  #
  # _yields_ temperature, rain_amount
  def rain_handler(&block) 
    yield 1, 2
  end
end
```

## Code Style

We are using this [Rubocop](https://github.com/bbatsov/rubocop) to enforce coding style.

```bash
rake rubocop # Run before each commit/push
rake rubocop:auto_correct # auto-corrects issues where it can

rubocop --only Style/TrailingBlankLines --auto-correct # correct only a single offense type
```

If you are a hundred percent sure you are doing the right thing, you can disable checking. Either

- disable them for a particular line/method/class with: `# rubocop:disable Metrics/LineLength, Style/StringLiterals`
- or disable rubocop for the full file: `# rubocop:disable all`
