
require File.expand_path("../../signal/read_data_process.rb",__FILE__)
require File.expand_path("../../signal/buy_signal.rb",__FILE__)

def back_test_one_stock(symbol,buy_policy_file,sell_policy_file,start_index,end_index)
    buy_policy_class=BuySettings.new(buy_policy_file)
    sell_policy_class=BuySettings.new(sell_policy_file)

    processed_data=read_data_process_file(symbol)

    price_hash=processed_data[0]
    macd_hash=processed_data[1]
    low_price_hash=processed_data[2]
    high_price_hash=processed_data[3]
    volume_hash=processed_data[4]


    buy_date=[]
    sell_date=[]

    #puts volume_hash

    price_array=price_hash.to_a
    price_array[start_index,end_index].each do |price|
    	date=price[0]
    	price_array=price[1]
    	macd_array=macd_hash[date]
    	low_price_array=low_price_hash[date]
    	high_price_array=high_price_hash[date]
    	volume_array=volume_hash[date]
        puts generate_price_buy_signal(price_array,buy_policy_class)

    end


end

if $0==__FILE__

	buy_policy_file=File.expand_path("../../signal/buy_policy_1.yml",__FILE__)
	sell_policy_file=File.expand_path("../../signal/sell_policy_1.yml",__FILE__)
    symbol="000009.sz"

    back_test_one_stock(symbol,buy_policy_file,sell_policy_file,10,30)


end