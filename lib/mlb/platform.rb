require "equalizer"
require "shale"

module MLB
  # Represents a platform
  class Platform < Shale::Mapper
    include Equalizer.new(:platform_code)

    # @!attribute [rw] platform_code
    #   Returns the platform code
    #   @api public
    #   @example
    #     platform.platform_code #=> "web"
    #   @return [String] the platform code
    attribute :platform_code, Shale::Type::String

    # @!attribute [rw] platform_description
    #   Returns the platform description
    #   @api public
    #   @example
    #     platform.platform_description #=> "Web"
    #   @return [String] the platform description
    attribute :platform_description, Shale::Type::String

    json do
      map "platformCode", to: :platform_code
      map "platformDescription", to: :platform_description
    end
  end
end
