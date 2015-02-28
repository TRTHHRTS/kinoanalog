json.array!(@genre_records) do |genre_record|
  json.extract! genre_record, :id
  json.url genre_record_url(genre_record, format: :json)
end
