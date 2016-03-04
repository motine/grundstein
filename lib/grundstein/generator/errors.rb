module Grundstein::Generator
  class GeneratorError < StandardError
  end
  class GeneratorNotFoundError < GeneratorError
  end
  class GeneratorMethodMissingError < GeneratorError
  end
end
