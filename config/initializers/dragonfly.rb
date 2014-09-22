require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "e87c8f134a370a1e68c3f6a581ec33f4fef1d7ad72afacdafc7d9a1d2a6c1f91"

  url_format "/name"

  datastore :s3,
   		bucket_name: 'blog_bank',
   		access_key_id: '#',
   		secret_access_key: '#'
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
