json.array!(@movies) do |movie|
  json.extract! movie, :id, :id, :title, :orig_title, :year, :release_date, :duration, :description, :rate_id
  json.url movie_url(movie, format: :json)
end
