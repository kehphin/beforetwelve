Rails.application.config.middleware.use OmniAuth::Builder do
  puts '========================================================================================'
  provider :steam, ENV["STEAM_WEB_API_KEY"]
end
