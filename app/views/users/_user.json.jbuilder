json.extract! user, :id, :avatar, :username, :role, :password_digest, :created_at, :updated_at
json.url user_url(user, format: :json)
