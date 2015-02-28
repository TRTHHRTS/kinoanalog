json.array!(@country_records) do |country_record|
  json.extract! country_record, :id
  json.url country_record_url(country_record, format: :json)
end
