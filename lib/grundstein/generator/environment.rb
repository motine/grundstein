require 'mustache'
require 'fileutils'

module Grundstein
  module Generator
    # This class is used to create the envrionment for the generator file.
    # This class is instanciated by the Generator::Loader.
    # Then `extend_from_file` is called. This will then load all methods available in that file into this object.
    # From there on the Loader can interact with the generator (e.g. call `run`)
    class Environment
      using Grundstein::Refinements::ColoredStrings

      def initialize
        @template_vars = {}
      end

      # Takes a kwargs and sets instance variables in the environment and makes them available as template variables.
      # Called by Generator::Loader.
      def set_context(**vars) # rubocop:disable Style/AccessorMethodName
        vars.each do |var, value|
          self.instance_variable_set("@#{var}".to_sym, value)
          @template_vars[var] = value
        end
      end

      # Loads the script from the given path and adds the methods to this class.
      # Called by Generator::Loader.
      def extend_from_file(path)
        self.instance_eval(File.read(path))
      end

      # This may be overridden by the `_generator.rb`.
      def caveats
        return ''
      end

      # Prints out a message.
      def info(action, message)
        puts "  #{action.ljust(10).c_info} #{message}"
      end

      # Sets a variable with the given `name` and `value` to be available for all future templates.
      def template_context(name, value)
        @template_vars[name] = value
      end

      # Ensures that the project has the directory given.
      # This method returns if the directory already existed.
      def directory(relative_project_path)
        path = File.expand_path(relative_project_path, @project_path)
        exists = Dir.exist?(path)
        if exists
          info("EXIST", path)
        else
          info("CREATE", path)
          FileUtils.mkdir_p(path)
        end
        return exists
      end

      # Convenience method for the generator
      # Processes the template found at `relative_project_path` and copies it to the project.
      # Relative_template_path determines the path of the template relative to the generator's root
      # If `destination_path` is nil, the destination path will be determined by appending `relative_template_path` to `@project_path`.
      # If `destination_path` is given, it may be an absolute path or a relative path (to `@project_path`).
      # In case the destination file already exists, the user will be queried what to do (append, overwrite, skip or print).
      # If `assume_append` is true, the user is not queried and the template will be appended.
      def template(relative_template_path, destination_path: nil, assume_append: false) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        template_path = File.join(@generator_path, relative_template_path)
        raise GeneratorRunError, "Could not find template '#{relative_template_path}'." unless File.exist?(template_path)

        destination_path = File.expand_path(relative_template_path, @project_path) if destination_path.nil?
        exists = File.exist?(destination_path)

        rendered_template = Mustache.render(File.read(template_path), @template_vars.merge(new_file?: !exists))

        append = true
        if exists && !assume_append
          choose do |menu|
            menu.prompt = "#{destination_path.c_warning} already exists. "
            menu.layout = :one_line
            menu.choice(:append) {}
            menu.choice(:overwrite) { append = false }
            menu.choice(:skip) do
              info("SKIP", destination_path)
              return
            end
            menu.choice(:print) do
              puts ">>>" * 20 + destination_path
              puts rendered_template
              puts "<<<" * 20 + destination_path
              return
            end
          end
          puts
        end
        File.open(destination_path, append ? 'a' : 'w') do |f|
          f.puts(rendered_template)
        end
        info((exists && append) ? "APPEND" : "CREATE", destination_path)
      end
    end
  end
end
