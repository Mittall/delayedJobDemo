json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :date_to_receive
  json.url user_url(user, format: :json)
end
