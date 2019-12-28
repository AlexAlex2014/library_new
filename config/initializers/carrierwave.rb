CarrierWave.configure do |config|
  # if Rails.env.production?
  #   config.storage = :fog
  # end
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id:  ENV.fetch('ACCESS_KEY_ID'),
      aws_secret_access_key: ENV.fetch('SECRET_ACCESS_KEY'),
      # use_iam_profile:       true,                         # optional, defaults to false
      region: ENV.fetch('REGION'),
      # host:                  's3.example.com',             # optional, defaults to nil
      # endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
  }
  config.fog_directory  = 'shrouded-earth-89697'
  # config.fog_public     = false                                                 # optional, defaults to true
  # config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
end