def run
  doc_existed = directory('doc') # ensure doc folder is there
  template('doc/.keep') unless doc_existed # and that there is a .keep if needed
  template('.gitignore', assume_append: true)
  template('Gemfile', assume_append: true)
  template('Rakefile', assume_append: true)
  template('README.Development.md', assume_append: true)
  template('README.md', assume_append: true)
end

def caveats
  res = <<CAVEATS
Please run `bundle install` in your project.

Rdoc is very free-form.
If you prefer a stricter way for documenting you code, please take a look at yardoc.org.
Especially in larger projects, a stricter style may be better suited.

CAVEATS
  return res
end

def spec
  return { desc: 'rdoc rake task using sdoc template' }
end