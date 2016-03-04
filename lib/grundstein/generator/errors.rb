module Grundstein::Generator
  class GeneratorError < StandardError
  end
  class GeneratorNotFoundError < GeneratorError
  end
  class GeneratorMalformedError < GeneratorError
  end
  class GeneratorRunError < GeneratorError
  end
end
