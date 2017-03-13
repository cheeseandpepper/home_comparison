json.extract! comment, :id, :created_at, :updated_at
json.url house_comments_url(comment, format: :json)