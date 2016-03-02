require 'thor'
module Grundstein
  class Runner < Thor
    desc :list, 'Lists all available templates.'
    def list
      puts 'TODO'
    end
    
    desc :add, 'Adds the given template to the current directory.'
    def run
      # TODO ask stuff
      # e.g.: gitignore will ask you if your intend to use Vagrant or Ruby or C...
    end
  end
end