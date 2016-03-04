def run
  # TODO ask for rails and add it to the template variables (e.g. `template_context('rails?', true)` )
  # p @generator_path, @working_path, @project_path
  #
  # TODO template('.rubocop.yml') # (introduce mustache)
  # TODO handle existing files: append, skip, overwrite, print (and ask again)
  
  # answer = ask("What do you think?")
  # puts "You have answered: #{answer}"
  # puts "hello! #{HighLine.color('hello!', :green, :bold)}"
  # choose do |menu|
  #   menu.prompt = "Please choose your favorite programming language? "
  #   menu.choice :ruby do say("Good choice!") end
  #   menu.choices(:python, :perl) do say("Not from around here, are you?") end
  # end
end

def caveats
  res = <<CAVEATS
TODO
# use `rubocop --auto-gen-config` and then inherit from this.
# in your CI, you may want to ...
#     - bundle exec rubocop
CAVEATS
  return res
end

def info
  return {
    desc: 'adds rubocop to Gemfile and Rakefile'
  }
end