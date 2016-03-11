# Grundstein

[![GitHub license](https://img.shields.io/github/license/motine/grunstein.svg?style=flat-square)]()
[![Gem](https://img.shields.io/gem/v/grundstein.svg?style=flat-square)]()

I was annoyed to do the same work over and over.
Often, I found myself to create the same `Vagrantfile`, `.gitignore` or `Gemfile` for each new project.
Grundstein automates this step in a very simple way: We have (smart) templates which are copied to your repo.
These templates are (in Rails fashion) called generators.

**Examples**

- You can call something like `grundstein vagrant` and you get a Vagrantfile and a little note in your README.
- When you call `grundstein rubocop` you get a .rubocop file with some defaults and a few lines in your Rakefile.

**Principles**

- Don't be smart detecting stuff, ask! (some stuff might not have been created by the developer yet)
- Generate rather more useful stuff than too few: A user can delete quicker than adding new stuff.
- Show the user what is happening and what needs to be done next.
- If in doubt, append.

**Pro Tip**: Commit before running generators. Then review the changes via `git diff` or a [visual git tool](https://desktop.github.com/).

## Installation

Please make sure you have `git >= 1.7` installed. Then run:

```bash
gem install grundstein
```

## Usage

The project's root folder is determined based on the current working directory.
If there is no `.git` directory in the current directory, the script will try to move up until it finds a `.git`.
Hence, **the project must be a git repository**.

```bash
grundstein list # see all generators
cd myproject
grundstein add rubocop
```

## Contribute & Development

Please see `README.Development.md`.
