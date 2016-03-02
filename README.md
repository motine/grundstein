# Grundstein

I am annoyed to do the same work over and over again for new projects.
Often, I find myself to create the same `Vagrantfile`, `.gitignore` or `Gemfile` over and over.
Grundstein automates this step in a very simple way: We have (smart) templates which are copied to your repo.

Examples:

- You can call something like `grundstein vagrant:fedora` and you get a Vagrantfile and a little note in your README.
- When you call `grundstein rubocop` you get a .rubocop file with some default and a few lines in your Rakefile.

## Installation

```bash
gem install grundstein
```

## Usage

TODO: Write usage instructions here

## Contributing

When developing (the gem is not installed yet), please use `RUBYLIB='/vagrant/lib:$RUBYLIB' bin/grundstein`  to run the project (assuming your project lives in `/vagrant`).

1. Fork it ( https://github.com/motine/grundstein/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
