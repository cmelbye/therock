CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAJRULZNRCK7UFXX5A',
    :aws_secret_access_key  => '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',
  }
  config.fog_directory  = "rockonline-#{Rails.env}"
end