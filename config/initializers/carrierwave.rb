require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

Dotenv.overload

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['SECRET_ACCESS_KEY'],
    region: 'ap-northeast-1'
  }

case Rails.env
  when 'development'
    config.fog_directory  = 'proto-space-image'
    config.asset_host = ENV['S3_URL']
  when 'production'
    config.fog_directory  = 'proto-space-image'
    config.asset_host = ENV['S3_URL']
  end
end
