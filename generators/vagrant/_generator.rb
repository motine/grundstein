def run
  template('Vagrantfile')
  template('README.Development.md', assume_append: true)
end

def spec
  return { desc: 'adds Vagrant' }
end
