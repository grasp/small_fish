
require 'settingslogic'

class AppSettings < Settingslogic
  source File.expand_path('../config/small_fish.yml', File.dirname(__FILE__))
end

class BuySettings < Settingslogic
source File.expand_path("../buy_policy_1.yml",__FILE__)
end

class SellSettings < Settingslogic
source File.expand_path("../sell_policy_1.yml",__FILE__)
 # source File.expand_path("../buy_policy_1.yml",__FILE__)
end

if $0==__FILE__ 
   puts AppSettings.app_name
   puts AppSettings.stock_list_path
end