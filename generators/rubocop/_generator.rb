def run
  ask_something
  puts 'hello from the generator'
end

def info
  return {
    desc: 'add rubocop'
  }
end