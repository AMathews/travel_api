require 'rails_helper'

describe WorldBank::CountryDataService do
  before do
    fixture_json = file_fixture('country_data_fixture.json').read
    allow(Faraday).to receive(:get).and_return(fixture_json)
  end

  context 'when looking for a country by code' do
    it 'returns country data for a valid uppercase three letter code' do
      expected = {
        'id' => 'BRA',
        'iso2Code' => 'BR',
        'name' => 'Brazil',
        'capitalCity' => 'Brasilia',
        'longitude' => '-47.9292',
        'latitude' => '-15.7801',
        'region' => a_kind_of(Hash),
        'adminregion' => a_kind_of(Hash),
        'incomeLevel' => a_kind_of(Hash),
        'lendingType' => a_kind_of(Hash)
      }

      output = described_class.new.country_by_code('BRA')
      expect(output).to match(expected)
    end

    it 'returns country data for a valid uppercase two letter code' do
      expected = {
        'id' => 'BRA',
        'iso2Code' => 'BR',
        'name' => 'Brazil',
        'capitalCity' => 'Brasilia',
        'longitude' => '-47.9292',
        'latitude' => '-15.7801',
        'region' => a_kind_of(Hash),
        'adminregion' => a_kind_of(Hash),
        'incomeLevel' => a_kind_of(Hash),
        'lendingType' => a_kind_of(Hash)
      }

      output = described_class.new.country_by_code('BR')
      expect(output).to match(expected)
    end

    it 'returns country data for a valid lowercase three letter code' do
      expected = {
        'id' => 'BRA',
        'iso2Code' => 'BR',
        'name' => 'Brazil',
        'capitalCity' => 'Brasilia',
        'longitude' => '-47.9292',
        'latitude' => '-15.7801',
        'region' => a_kind_of(Hash),
        'adminregion' => a_kind_of(Hash),
        'incomeLevel' => a_kind_of(Hash),
        'lendingType' => a_kind_of(Hash)
      }

      output = described_class.new.country_by_code('bra')
      expect(output).to match(expected)
    end

    it 'returns country data for a valid lowercase two letter code' do
      expected = {
        'id' => 'BRA',
        'iso2Code' => 'BR',
        'name' => 'Brazil',
        'capitalCity' => 'Brasilia',
        'longitude' => '-47.9292',
        'latitude' => '-15.7801',
        'region' => a_kind_of(Hash),
        'adminregion' => a_kind_of(Hash),
        'incomeLevel' => a_kind_of(Hash),
        'lendingType' => a_kind_of(Hash)
      }

      output = described_class.new.country_by_code('br')
      expect(output).to match(expected)
    end
  end

  context 'when looking for capitals in a coordinate box' do
    it 'returns country data for a given coordinate box' do
      expected = [{
        'id' => 'GBR',
        'iso2Code' => 'GB',
        'name' => 'United Kingdom',
        'capitalCity' => 'London',
        'longitude' => '-0.126236',
        'latitude' => '51.5002',
        'region' => a_kind_of(Hash),
        'adminregion' => a_kind_of(Hash),
        'incomeLevel' => a_kind_of(Hash),
        'lendingType' => a_kind_of(Hash)
      }]

      coordinates = {
        min_lat: 40.0,
        max_lat: 60.0,
        min_long: -3.0,
        max_long: 0.0
      }

      output = described_class.new.find_countries_capitals_in_area(coordinates)
      expect(output).to match(expected)
    end
  end
end
