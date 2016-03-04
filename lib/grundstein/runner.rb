require 'thor'
require 'highline/import'


module Grundstein
  class Runner < Thor
    using Grundstein::Refinements::ColoredStrings
    
    desc :list, 'Lists all available generators.'
    def list
      # answer = ask("What do you think?")
      # puts "You have answered: #{answer}"
      # puts "hello! #{HighLine.color('hello!', :green, :bold)}"
      # choose do |menu|
      #   menu.prompt = "Please choose your favorite programming language? "
      #   menu.choice :ruby do say("Good choice!") end
      #   menu.choices(:python, :perl) do say("Not from around here, are you?") end
      # end
      Generator::Loader.list do |name, desc|
        puts "  #{name.ljust(20).c_gen} #{desc}"
      end
    rescue Generator::GeneratorError => e
      puts "ERROR: #{e.to_s.c_error}"
    end
    
    desc 'add NAME', 'Runs the given generator in the current directory.'
    def add(generator_name)
      generator = Generator::Loader.new(generator_name)
      generator.run
    rescue Generator::GeneratorError => e
      puts "ERROR: #{e.to_s.c_error}"
      # TODO ask stuff (https://github.com/JEG2/highline)
      # e.g.: gitignore will ask you if your intend to use Vagrant or Ruby or C...
    end
    
    # desc :update, 'Update the generators.'
    # def update
    #   # re-check out the repository's templates folder
    # end
  end
end