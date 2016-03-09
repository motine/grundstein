require 'thor'
require 'highline/import'

module Grundstein
  class Runner < Thor
    using Grundstein::Refinements::ColoredStrings

    desc :list, 'Lists all available generators.'
    def list
      Generator::Repository.instance.generators.each do |name|
        gen = Generator::Loader.new(name)
        puts "  #{gen.name.ljust(20).c_gen} #{gen.desc}"
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
      # TODO: ask stuff (https://github.com/JEG2/highline)
      # e.g.: gitignore will ask you if your intend to use Vagrant or Ruby or C...
    end
  end
end
