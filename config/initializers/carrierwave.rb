# frozen_string_literal: true

require 'carrierwave/mongoid'

CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id:  ENV.fetch('ACCESS_KEY_ID'),
      aws_secret_access_key: ENV.fetch('SECRET_ACCESS_KEY'),
      region: ENV.fetch('REGION')
  }
  config.fog_directory  = 'shrouded-earth-89697'

  config.storage = :grid_fs
end
