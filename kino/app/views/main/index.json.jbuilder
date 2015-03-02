json.array!(@mains) do |main|
  json.extract! main, :id
  json.url main_url(main, format: :json)
end
