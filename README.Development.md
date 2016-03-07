## API documentation

We are using the [sdoc](https://github.com/voloko/sdoc) generator which is based on [rdoc](https://github.com/rdoc/rdoc).
You may generate the documentation via `rake rdoc` and then find it in `doc/api`.

For documenting methods and classes we use [markdown](https://daringfireball.net/projects/markdown/). Just add a comment above a class, method or attribute.
If you are not familiar with markdown, please see this [cheat sheet](http://nestacms.com/docs/creating-content/markdown-cheat-sheet).  
Here a quick example:

```ruby
# This is a mountain in the landscape.
# It has seasons and simulates weather.
class Mountain
  # The hight of the mountain [meter].
  attr_accessor :height
  
  # Constructor.
  # The `height` is measured in meters.
  # If snow is true, we can build ski lifts.
  def initialize(height, snow=false)
  end
  
  # Changes the weather on the mountain and sends a letter to the weather god.
  # `season` can be either `:summer`, `:spring`, `:fall` or `:winter`.
  # The letter to the weather god will include the desired `min_temp` or `max_temp`.
  #
  #     m = Mountain.new(1000)    # this is some example code
  #     m.change_season(:summer) 
  def change_season(season, min_temp: -10, max_temp: 30)
  end

  # Whenever rain occures, the block will be executed.
  # **WARNING**: Will be called from another thread.
  #
  # _yields_ temperature, rain_amount
  def rain_handler(&block) 
    yield 1, 2
  end
end
```

## Code Style

We are using this [Rubocop](https://github.com/bbatsov/rubocop) to enforce coding style.

```bash
rake rubocop # Run before each commit/push
rake rubocop:auto_correct # auto-corrects issues where it can

rubocop --only Style/TrailingBlankLines --auto-correct # correct only a single offense type
```

If you are a hundred percent sure you are doing the right thing, you can disable checking. Either

- disable them for a particular line/method/class with: `# rubocop:disable Metrics/LineLength, Style/StringLiterals`
- or disable rubocop for the full file: `# rubocop:disable all`
