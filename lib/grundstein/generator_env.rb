module Grundstein
  class GeneratorEnv
    def ask_something
      puts "ask_something was called"
    end
  
    def load_generator(path)
      self.instance_eval(File.read(path))
    end
  end
end
