require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module U
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.paperclip_defaults = {
      storage: :s3,
      s3_protocol: 'https',
      bucket: ENV['S3_BUCKET_NAME'],
      path: "/#{Rails.env}/:class/:attachment/:id_partition/:basename-:style.:extension",
      s3_host_name: 's3-us-west-2.amazonaws.com',
      s3_region: 'us-west-2',
      s3_credentials: {
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
      }
    }
  end
end
