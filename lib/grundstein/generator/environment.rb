require 'mustache'

module Grundstein::Generator
  class Environment
    using Grundstein::Refinements::ColoredStrings
    
    def initialize
      @template_vars = {}
    end
    
    # takes a kwargs and sets instance variables in the environment
    # called from loader
    def set_context(**vars)
      vars.each do |var, value|
        self.instance_variable_set("@#{var}".to_sym, value)
        @template_vars[var] = value
      end
    end

    # loads the script from the given path and adds the methods to this class
    # called from loader
    def extend_from_file(path)
      self.instance_eval(File.read(path))
    end

    # this may be overridden by the _generator
    # returns a 
    def caveats
      return ''
    end
    
    def info(action, message)
      puts "  #{action.ljust(10).c_info} #{message}"
    end

    # add a variable (`name`) with the given value to all future template contexts
    def template_context(name, value)
      @template_vars[name] = value
    end
    
    # Convenience method for the generator
    # Relative_template_path determines the path of the template relative to the generator's root
    # If `destination_path` is nil, the destination path will be determined by appending `relative_template_path` to `@project_path`.
    # If `destination_path` is given, it may be an absolute path or a relative path (to `@project_path`).
    # In case the destination file already exists, the user will be queried what to do (append, overwrite, skip or print).
    # If `assume_append` is true, the user is not queried and the template will be appended.
    def template(relative_template_path, destination_path: nil, assume_append: false)
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
          menu.choice(:append) { }
          menu.choice(:overwrite) { append = false }
          menu.choice(:skip) { info("SKIP", destination_path); return }
          menu.choice(:print) { puts ">>>" * 20 + destination_path; puts rendered_template; puts "<<<" * 20 + destination_path; return }
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
