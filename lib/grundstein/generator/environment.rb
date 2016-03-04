module Grundstein::Generator
  class Environment
    using Grundstein::Refinements::ColoredStrings
    
    # takes a kwargs and sets instance variables in the environment
    # called from loader
    def set_context(**vars)
      vars.each do |var, value|
        self.instance_variable_set("@#{var}".to_sym, value)
      end
    end

    # loads the script from the given path and adds the methods to this class
    # called from loader
    def extend_from_file(path)
      self.instance_eval(File.read(path))
    end

    # def ask_something
    #   puts "ask_something was called"
    # end

    # this may be overridden by the _generator
    def caveats
      return ''
    end
  end
end
