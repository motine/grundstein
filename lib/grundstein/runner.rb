require 'thor'
require 'highline/import'

module Grundstein
  class Runner < Thor
    desc :list, 'Lists all available generators.'
    def list
      answer = ask("What do you think?")
      puts "You have answered: #{answer}"
      puts "hello! #{HighLine.color('hello!', :green, :bold)}"
      choose do |menu|
        menu.prompt = "Please choose your favorite programming language? "
        menu.choice :ruby do say("Good choice!") end
        menu.choices(:python, :perl) do say("Not from around here, are you?") end
      end
    end
    
    desc :add, 'Runs the given generator in the current directory.'
    def add(generator_name)
      env = GeneratorEnv.new
      env.load_generator(generator_script_path(generator_name))
      env.run
      # TODO ask stuff (https://github.com/JEG2/highline)
      # e.g.: gitignore will ask you if your intend to use Vagrant or Ruby or C...
    end
    
    desc :update, 'Update the generators.'
    def update
      # re-check out the repository's templates folder
    end
    
    protected
    
    def generator_path(generator_name)
      return File.expand_path(File.join('..', '..', '..', 'generators', generator_name, __FILE__)
    end
    
    def generator_script_path(generator_name)
      return File.join(generator_path(generator_name), '_generator.rb')
    end
  end
end