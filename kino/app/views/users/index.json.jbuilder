json.array!(@users) do |user|
  json.extract! user, :id, :id, :name, :password, :permission_type, :email
  json.url user_url(user, format: :json)
end
