require "equalizer"
require "shale"

module MLB
  # Represents a language
  class Language < Shale::Mapper
    include Equalizer.new(:language_id)

    # @!attribute [rw] language_id
    #   Returns the unique language identifier
    #   @api public
    #   @example
    #     language.language_id #=> 1
    #   @return [Integer] the unique language identifier
    attribute :language_id, Shale::Type::Integer

    # @!attribute [rw] language_code
    #   Returns the language code
    #   @api public
    #   @example
    #     language.language_code #=> "en"
    #   @return [String] the language code
    attribute :language_code, Shale::Type::String

    # @!attribute [rw] name
    #   Returns the language name
    #   @api public
    #   @example
    #     language.name #=> "English"
    #   @return [String] the language name
    attribute :name, Shale::Type::String

    # @!attribute [rw] locale
    #   Returns the locale identifier
    #   @api public
    #   @example
    #     language.locale #=> "en_US"
    #   @return [String] the locale identifier
    attribute :locale, Shale::Type::String

    json do
      map "languageId", to: :language_id
      map "languageCode", to: :language_code
      map "name", to: :name
      map "locale", to: :locale
    end
  end
end
