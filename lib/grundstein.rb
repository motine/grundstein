require_relative 'grundstein/version'

module Grundstein # rubocop:disable Style/Documentation
  def self.lib_path
    File.expand_path('..', __FILE__)
  end
end

require_relative 'grundstein/refinements'
require_relative 'grundstein/generator'
require_relative 'grundstein/runner'
