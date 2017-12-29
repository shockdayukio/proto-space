class AvatarUploader < CarrierWave::Uploader::Base

  case Rails.env
  when 'production'; storage :fog
  when 'development'; storage :fog
  when 'test'; storage :file
  else storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
