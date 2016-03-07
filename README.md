# Grundstein

I am annoyed to do the same work over and over again for new projects.
Often, I find myself to create the same `Vagrantfile`, `.gitignore` or `Gemfile` over and over.
Grundstein automates this step in a very simple way: We have (smart) templates which are copied to your repo.
These templates are (in Rails fashion) called generators.

**Examples**

- You can call something like `grundstein vagrant:fedora` and you get a Vagrantfile and a little note in your README.
- When you call `grundstein rubocop` you get a .rubocop file with some default and a few lines in your Rakefile.

**Principles**

- Don't try to be too smart detecting stuff, because some stuff might not have been created by the user.
- Ask the user what he/she wants (e.g. "Do you intend to use Rails?").
- Generate rather more useful stuff than too few: A user ca delete quicker than adding new stuff.
- Show the user what is happening and what needs to be done next.
- Append don't replace.

**Pro Tip**: Commit before running generators. Then review the changes via `git diff` or a [visual git tool](https://desktop.github.com/).

## Installation

```bash
gem install grundstein
```

## Usage

**Assumption**: The project root folder is determined by the current working directory. If in there is no `.git` directory, the script will try to move up and up until it finds `.git`.
TODO: Write usage instructions here

# Development

<!-- move to README.Development.md -->

## How generators work

Each generator has a directory in the `generators` folder. The name is determined by the directory's name.
Directories starting with `.` or `#` are ignored. All others must have a `_generator.rb` file. In there:

- must be a `def run` method.
- must be a `def spec` method which returns a hash with at least `{desc: '....'}`.
- may have a `def caveats` method which returns a string to be displayed after the generator has run.
- can be arbitrary other methods or declarations.

<!-- EXAMPLES for generator scripts -->

In the run method, you have available to you:

```ruby
@generator_path, @working_path, @project_path
```

In templates you always can query for

- `existed?` if the file was already there
- `project_path`, more precisely all variables (@generator_path, etc.) are available to the template
- and you can use `template_context(name, value)` to add stuff from the generator (use a question mark at the end of the name for boolean values).

<!-- TODO example templates with sections-->



## Testing

```bash
# you should test your generators in a new project
cd /tmp/
git init myproject
cd myproject/
RUBYLIB='/vagrant/lib:$RUBYLIB' bin/grundstein add rubocop
```

## Contributing
<!-- document the order of runner -> loader -> environment -->
When developing (the gem is not installed yet), please use `RUBYLIB='/vagrant/lib:$RUBYLIB' bin/grundstein`  to run the project (assuming your project lives in `/vagrant`).

1. Fork it ( https://github.com/motine/grundstein/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

