class CountriesController < ApplicationController
  def index
    render json: all_countries
  end

  def basic_info
    render json: basic_info_body(params[:code])
  end

  def find_capitals_by_coordinates
    coordinates = params.permit(:min_lat, :max_lat, :min_long, :max_long).to_h
    render json: capital_list(coordinates)
  end

  protected

  def country_data_service
    WorldBank::CountryDataService.new
  end

  def all_countries
    country_data_service.countries
  end

  def basic_info_body(code)
    country_info = country_data_service.country_by_code(code)
    country_info.slice('name', 'capitalCity')
  end

  def capital_list(coordinates)
    float_coordinates = coordinates.transform_values(&:to_f)
    capitals = country_data_service.find_countries_capitals_in_area(float_coordinates)

    capitals.map { |capital| capital.slice('name', 'capitalCity') }
  end
end
