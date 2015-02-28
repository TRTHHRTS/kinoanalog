json.array!(@countries) do |country|
  json.extract! country, :id, :id, :name
  json.url country_url(country, format: :json)
end
