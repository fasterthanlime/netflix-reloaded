module Netflix
  class Title < Valuable
    has_value :data
    has_value :id
    has_value :release_year
    has_collection :genres
    has_collection :actors
    has_value :title
    has_value :web_page

    def delivery_formats
      @delivery_formats ||= FormatBuilder.request_formats_for(data)
    end

    def to_json
      attributes.to_json
    end

    def self.from_json(data)
      self.new(JSON.parse(data))
    end

    def to_s
      "#{title || 'unknown title'} (#{release_year})"
    end

    class << self

      def complete_list
        data = Netflix::API::Catalog::Titles.index
        TitleBuilder.from_xml(data)
      end

      def search(term, params = {})
        full_params = params.merge(:term => term)
        full_params.each { |k, v| full_params[k] = URI.escape(v) }

        data = Netflix::API::Catalog::Titles.search(full_params)
        TitleBuilder.from_xml(data)
      end

    end
  end # class Title
end # module Netflix

