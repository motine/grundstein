module Grundstein
  module Generator
    class Environment
      def ask_something
        puts "ask_something was called"
      end
  
      def extend_from_file(path)
        self.instance_eval(File.read(path))
      end
    end
  end
end
