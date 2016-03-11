require 'highline'

# We are not using Refinements, so we can support earlier Ruby versions
# module Grundstein
#   module Refinements
#     # Add namespaced refinement for the color scheme (we are not using HighLine's stuff like `ColorScheme` or `HighLine.colorize_strings`).
#     module ColoredStrings
#       refine String do

# Add namespaced refinement for the color scheme (we are not using HighLine's stuff like `ColorScheme` or `HighLine.colorize_strings`).
class String
  def c_gen
    HighLine.color(self, :blue, :bold)
  end

  def c_info
    HighLine.color(self, :green, :bold)
  end

  def c_warning
    HighLine.color(self, :yellow, :bold)
  end

  def c_error
    HighLine.color(self, :red, :bold)
  end
end
