
require File.expand_path("../../signal/read_data_process.rb",__FILE__)
require File.expand_path("../../signal/buy_signal.rb",__FILE__)

def back_test_one_stock(symbol,buy_policy_file,sell_policy_file,start_index,end_index)
    buy_policy_class=BuySettings.new(buy_policy_file)
    sell_policy_class=SellSettings.new(sell_policy_file)

    processed_data=read_data_process_file(symbol)
    price_hash=processed_data[0]
    full_price_array=price_hash.to_a

    buy_date=[]
    sell_date=[]

    #index is back_days in full price array, as we sort with date
    (end_index-1).downto(start_index).each do |index|

      date=full_price_array[index][0]
      price_array=full_price_array[index][1]

      buy_signal=generate_buy_signal(processed_data,index,buy_policy_class)
      #puts "buy_signal=#{buy_signal}"
        if buy_signal==true
          puts "buy on #{date} with price #{price_array[3]} with buy signal #{buy_signal}" 
        end

      sell_signal=generate_sell_signal(processed_data,index,sell_policy_class)

        if sell_signal==true
          puts "sell on #{date} with price #{price_array[3]}"  
        end

    end


end

if $0==__FILE__

	buy_policy_file=File.expand_path("../../signal/buy_policy_1.yml",__FILE__)
	sell_policy_file=File.expand_path("../../signal/sell_policy_1.yml",__FILE__)
    symbol="000009.sz"

    back_test_one_stock(symbol,buy_policy_file,sell_policy_file,10,50)


end