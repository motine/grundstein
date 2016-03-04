def run(generator_path, working_path, project_path)
  puts "Generator dir: #{generator_path}"
  puts "Current dir: #{working_path}"
  puts "Project dir: #{project_path}"
  # answer = ask("What do you think?")
  # puts "You have answered: #{answer}"
  # puts "hello! #{HighLine.color('hello!', :green, :bold)}"
  # choose do |menu|
  #   menu.prompt = "Please choose your favorite programming language? "
  #   menu.choice :ruby do say("Good choice!") end
  #   menu.choices(:python, :perl) do say("Not from around here, are you?") end
  # end
end

def info
  return {
    desc: 'adds rubocop to Gemfile and Rakefile'
  }
end