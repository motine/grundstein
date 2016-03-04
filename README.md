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

## Installation

```bash
gem install grundstein
```

## Usage

TODO: Write usage instructions here

## How generators work

Each generator has a directory in the `generators` folder. The name is determined by the directory's name.
Directories starting with `.` or `#` are ignored. All others must have a `_generator.rb` file. In there:

- must be a `def run` method.
- must be a `def info` method which returns a string.
- can be arbitrary other methods or declarations.

## Contributing
<!-- document the order of runner -> loader -> environment -->
When developing (the gem is not installed yet), please use `RUBYLIB='/vagrant/lib:$RUBYLIB' bin/grundstein`  to run the project (assuming your project lives in `/vagrant`).

1. Fork it ( https://github.com/motine/grundstein/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
