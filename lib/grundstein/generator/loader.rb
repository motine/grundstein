module Grundstein::Generator
  class Loader
    SCRIPT_NAME = '_generator.rb'
    
    def initialize(generator_name)
      @generator_name = generator_name
      @env = load_environment
    end

    def run
      raise GeneratorMalformedError, "Generator script '#{@generator_name}' does not have a 'run' method." unless @env.respond_to?(:run)
      @env.run
    end
    
    def name
      return @generator_name
    end
    
    def info
      raise GeneratorMalformedError, "Generator script '#{@generator_name}' does not have an 'info' method." unless @env.respond_to?(:info)
      info = @env.info
      raise GeneratorMalformedError, "Generator script '#{@generator_name}' does include :desc in the 'info' result." unless info.is_a?(Hash) && info[:desc].is_a?(String)
      return info
    end
    
    # Iteratates through all generators and yields the block with the |name, desc|.
    def self.list(&block)
      Dir.foreach(generators_path) do |gen_dir|
        next if gen_dir.start_with?('.') || gen_dir.start_with?('#')
        gen = self.new(gen_dir)
        yield gen.name, gen.info[:desc]
      end
    end

    protected
    # Creates a Generator::Environment for the generator_name given in the constructor.
    def load_environment
      env = Grundstein::Generator::Environment.new
      path = self.generator_script_path
      raise GeneratorNotFoundError, "Generator named '#{@generator_name}' could not be found." unless Dir.exist?(File.dirname(path))
      raise GeneratorNotFoundError, "Generator named '#{@generator_name}' has no #{SCRIPT_NAME} script." unless File.exist?(path)
      env.extend_from_file(path)
      return env
    end

    def self.generators_path
      return File.join(Grundstein.lib_path, '..', 'generators')
    end
    def generator_path
      return File.join(self.class.generators_path, @generator_name)
    end
  
    def generator_script_path
      return File.join(self.generator_path, SCRIPT_NAME)
    end
  end
end
