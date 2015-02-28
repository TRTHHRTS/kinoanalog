json.array!(@reviews) do |review|
  json.extract! review, :id, :id, :title, :review_date, :content
  json.url review_url(review, format: :json)
end
