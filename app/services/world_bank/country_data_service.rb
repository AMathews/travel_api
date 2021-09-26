# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'

module WorldBank
  class UnsupportedCountryCode < StandardError; end

  class CountryDataService
    # Using a class variable as a quick/simple cache for rarely changing data. It's generally bad practice.
    @@fetched_data = nil

    def initialize
      @@fetched_data ||= fetch_raw_data
      super
    end

    def countries
      @@fetched_data.body.last
    end

    def country_by_code(code)
      case code&.length
      when 2
        countries_by_2_letter[code.upcase]
      when 3
        countries_by_3_letter[code.upcase]
      else
        raise UnsupportedCountryCode, "Unsupported Country Code: #{code}"
      end
    end

    # @param [Hash] coordinates
    def find_countries_capitals_in_area(coordinates)
      found_capitals = []

      countries.each do |country|
        next unless country['latitude'].to_f > coordinates[:min_lat] &&
                    country['latitude'].to_f < coordinates[:max_lat] &&
                    country['longitude'].to_f > coordinates[:min_long] &&
                    country['longitude'].to_f < coordinates[:max_long]

        found_capitals.push(country)
      end

      found_capitals
    end

    protected

    def fetch_raw_data
      conn = Faraday.new do |f|
        f.response :json
      end

      # Need additional error handling (timeouts, outages, etc.)
      conn.get 'https://api.worldbank.org/v2/country?format=json&per_page=300'
    end

    def countries_by_2_letter
      @countries_by_2_letter ||= countries.index_by { |country| country['iso2Code'] }
    end

    def countries_by_3_letter
      @countries_by_3_letter ||= countries.index_by { |country| country['id'] }
    end
  end
end
