module Grundstein
  module Generator
    # This class encapsulates the logic to load a generator.
    # It sets up a Generator::Envrionment and interacts with it.
    # It is also responsible to determine paths.
    class Loader
      using Grundstein::Refinements::ColoredStrings

      SCRIPT_NAME = '_generator.rb'.freeze
      DIR_EXPECTED_IN_PROJECT_ROOT = '.git'.freeze

      # Loads the generator.
      def initialize(generator_name)
        @generator_name = generator_name
        @env = load_environment
        @env.set_context(generator_path: generator_path, working_path: wp, project_path: prp)
      end

      # Executes the generator's run method.
      def run # rubocop:disable Metrics/MethodLength
        raise GeneratorMalformedError, "Generator script '#{@generator_name}' does not have a 'run' method." unless @env.respond_to?(:run)
        begin
          wp = Dir.pwd
          prp = project_root_path
          puts "Running #{@generator_name.c_gen}"
          puts "Working path: #{wp}"
          puts "Project path: #{prp}"
          puts
          @env.run
          puts
          puts @env.caveats.c_warning
        rescue => e
          raise GeneratorRunError, "[#{@generator_name}] #{e.message}"
        end
      end

      def name
        return @generator_name
      end

      def info
        raise GeneratorMalformedError, "Generator script '#{@generator_name}' does not have an 'info' method." unless @env.respond_to?(:spec)
        spec = @env.spec
        raise GeneratorMalformedError, "Generator script '#{@generator_name}' does include :desc in the 'info' result." unless spec.is_a?(Hash) && spec[:desc].is_a?(String)
        return spec
      end

      # short hand for info[:desc]
      def desc
        return info[:desc]
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

      def generator_path
        return Generator::Repository.instance.generator_path(@generator_name)
      end

      def generator_script_path
        return File.join(self.generator_path, SCRIPT_NAME)
      end

      def project_root_path
        dir = Dir.pwd
        loop do
          raise GeneratorRunError, "Could not determine project path (no .git found here or above)." if dir == '/'
          return dir if Dir.exist?(File.join(dir, DIR_EXPECTED_IN_PROJECT_ROOT))
          dir = File.dirname(dir)
        end
      end
    end
  end
end
