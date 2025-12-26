require_relative "error"

module MLB
  # Error raised when too many HTTP redirects are encountered
  class TooManyRedirects < Error; end
end
