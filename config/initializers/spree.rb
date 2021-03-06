# Configure Spree Preferences
# 
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do: 
# config.setting_name = 'new value'

require 'product_filters'

Spree.config do |config|
  # Example:
  # Uncomment to override the default site name.
  # config.site_name = "Spree Demo Site"
#  config.set(:enabled_locales, ['en','es','fr', 'pt'])
  config.set(logo: "logo-450.png")  
  config.set(:allow_ssl_in_production, false)
end


#Spree::Config.set :enabled_locales => ['en','es','fr', 'pt']
