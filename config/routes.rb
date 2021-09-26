Rails.application.routes.draw do
  get 'countries/', to: 'countries#index'
  get 'countries/basic_info/:code', to: 'countries#basic_info'
  get 'countries/find_capitals/:min_lat/:max_lat/:min_long/:max_long', to: 'countries#find_capitals_by_coordinates'
end
