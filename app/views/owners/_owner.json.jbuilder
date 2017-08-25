json.extract! owner, :id, :code, :password_digest, :created_at, :updated_at
json.url owner_url(owner, format: :json)
