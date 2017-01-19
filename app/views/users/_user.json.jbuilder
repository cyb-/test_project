json.extract! user, :id, :email, :first_name, :last_name, :created_at
json.url user_url(user, format: :json)