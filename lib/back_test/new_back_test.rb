
require File.expand_path("../../signal/read_data_process.rb",__FILE__)
require File.expand_path("../../signal/buy_signal.rb",__FILE__)

def back_test_one_stock(symbol,buy_policy_file,sell_policy_file,start_index,end_index)
    buy_policy_class=BuySettings.new(buy_policy_file)
    sell_policy_class=SellSettings.new(sell_policy_file)

    processed_data=read_data_process_file(symbol)

    price_hash=processed_data[0]
    macd_hash=processed_data[1]
    low_price_hash=processed_data[2]
    high_price_hash=processed_data[3]
    volume_hash=processed_data[4]


    buy_date=[]
    sell_date=[]

    #puts volume_hash

     full_price_array=price_hash.to_a

    #price_array[start_index,end_index].reverse.each_index do |index|
    (end_index-1).downto(start_index).each do |index|
    	date=full_price_array[index][0]
        #puts "first date=#{date},index=#{index}"
    	price_array=full_price_array[index][1]

    	macd_array=macd_hash[date]
        low_price_array=low_price_hash[date]
    	high_price_array=high_price_hash[date]
    	volume_array=volume_hash[date]
        #puts "last price =#{price_array[27]}"
        last_date=full_price_array[index-1][0]
        last_price=full_price_array[index-1][1]
        last_macd_array=macd_hash[last_date]
        last_low_price_array=low_price_hash[last_date]
        last_high_price_array=high_price_hash[last_date]
        last_volume_array=volume_hash[last_date]

        buy_signal=true
        sell_signal=true

        price_signal = generate_price_buy_signal(price_array,buy_policy_class)
        macd_signal = generate_macd_buy_signal(macd_array,buy_policy_class)

        last_macd_signal = generate_last_macd_buy_signal(last_macd_array,buy_policy_class)

        low_price_signal = generate_low_price_buy_signal(low_price_array,price_array,buy_policy_class)
        high_price_signal = generate_high_price_buy_signal(high_price_array,price_array,buy_policy_class)
        volume_signal = generate_volume_buy_signal(volume_array,buy_policy_class)

        #puts "price_signal=#{price_signal},macd_signal=#{macd_signal},last_macd_signal=#{last_macd_signal},low_price_signal=#{low_price_signal},high_price_signal=#{high_price_signal},volume_signal=#{volume_signal}"
        buy_signal=price_signal && macd_signal && last_macd_signal && low_price_signal && high_price_signal && volume_signal
        if buy_signal
        puts "buy on #{date} with price #{price_array[3]}" 
        print last_macd_array
        puts ""
         print  macd_array

        end

        #BuySettings.reload!
        sell_signal &&= generate_price_buy_signal(price_array,sell_policy_class)
        sell_signal &&= generate_macd_buy_signal(macd_array,sell_policy_class)
        sell_signal &&= generate_last_macd_buy_signal(last_macd_array,sell_policy_class)

        sell_signal &&= generate_low_price_buy_signal(low_price_array,price_array,sell_policy_class)
        sell_signal &&= generate_high_price_buy_signal(high_price_array,price_array,sell_policy_class)
        sell_signal &&= generate_volume_buy_signal(volume_array,sell_policy_class)
        puts "sell on #{date} with price #{price_array[3]}"  if sell_signal

    end


end

if $0==__FILE__

	buy_policy_file=File.expand_path("../../signal/buy_policy_1.yml",__FILE__)
	sell_policy_file=File.expand_path("../../signal/sell_policy_1.yml",__FILE__)
    symbol="000009.sz"

    back_test_one_stock(symbol,buy_policy_file,sell_policy_file,10,50)


end