require 'settingslogic'
require File.expand_path("../read_data_process.rb",__FILE__)

class BuySettings < Settingslogic

source File.expand_path("../buy_policy_1.yml",__FILE__)
 # source File.expand_path("../buy_policy_1.yml",__FILE__)

end

#bpc :buy policy class
#依次为开盘，最高，最低，收盘，成交量
def generate_price_buy_signal(price_array,bpc)
	buy_signal=true

	#开盘价大于收盘价
	unless bpc.price.nil?
	 buy_signal &&=bpc.price.open_bigger_close  && (price_array[0].to_f > price_array[3].to_f) if  bpc.price.respond_to?("open_bigger_close")
    #开盘价为最高价
	 buy_signal &&=bpc.price.open_equal_high  && (price_array[0].to_f == price_array[1].to_f) if  bpc.price.respond_to?("open_equal_high")
	#开盘价为最低价
	 buy_signal &&=bpc.price.open_equal_low  && (price_array[0].to_f == price_array[2].to_f) if   bpc.price.respond_to?("open_equal_low")
    #收盘价为最低价
    buy_signal &&=bpc.price.close_equal_low  && (price_array[3].to_f == price_array[2].to_f) if  bpc.price.respond_to?("close_equal_low")
    #收盘价为最高价
    buy_signal &&=bpc.price.close_equal_high  && (price_array[3].to_f == price_array[1].to_f) if  bpc.price.respond_to?("close_equal_high ")
    
    puts buy_signal
    end


end

def generate_macd_buy_signal(macd_array,buy_policy_class)
	puts (buy_policy_class.price.price_open_bigger_close) && (price_array[0].to_f > price_array[3].to_f)
end

def generate_low_price_buy_signal(low_price_array,buy_policy_class)
	puts (buy_policy_class.price.price_open_bigger_close) && (price_array[0].to_f > price_array[3].to_f)
end

def generate_high_price_buy_signal(high_price_array,buy_policy_class)
	puts (buy_policy_class.price.price_open_bigger_close) && (price_array[0].to_f > price_array[3].to_f)
end

def generate_volume_buy_signal(volume_array,buy_policy_class)
	puts (buy_policy_class.price.price_open_bigger_close) && (price_array[0].to_f > price_array[3].to_f)
end




if $0==__FILE__

processed_data_array=read_data_process_file("000009.sz")
buy_policy_class=BuySettings.new(File.expand_path("../buy_policy_1.yml",__FILE__))

processed_data_array[0].each do |date,price_array|
	generate_price_buy_signal(price_array,buy_policy_class)
end

end