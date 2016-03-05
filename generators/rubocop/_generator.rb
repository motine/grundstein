def run
  template_context("rails?", agree("Do you intend to use Rails?  "))
  template('.rubocop.yml')
  template('Gemfile', assume_append: true)
  template('Rakefile', assume_append: true)
  template('README.Development.md', assume_append: true)
end

def caveats
  res = <<CAVEATS
Please run `bundle install` in your project.
  
You can use `rubocop --auto-gen-config` to automatically create `.rubocop_todo.yml`.
In your `.rubocop.yml` you can then add `inherit_from: .rubocop_todo.yml` to include it.
More info: https://github.com/bbatsov/rubocop#automatically-generated-configuration


If you are using a CI, you may want to include something like `bundle exec rubocop`.
CAVEATS
  return res
end

def spec
  return {
    desc: 'adds rubocop to Gemfile and Rakefile'
  }
end