def run
  template('tm_properties', destination_path: '.tm_properties')
end

def spec
  return { desc: 'adds TextMate config' }
end
