require File.expand_path("../low_high_price_history.rb",__FILE__)
require File.expand_path("../macd_history.rb",__FILE__)
require File.expand_path("../volume_history.rb",__FILE__)

def append_data(symbol,price_hash,back_day)

  low_high=low_high_price_array_on_backdays(price_hash,back_day)
  low_price_array=low_high[0]
  high_price_array=low_high[1]

  result_macd_array=generate_macd_on_backday(price_hash,back_day)

  volume_array=generate_volume_array_on_backday(price_hash,back_day)
  date=price_hash.to_a[0][0]

  processed_data_path=File.expand_path("../../../resources/data_process/#{symbol}.txt",__FILE__)
  processed_data_file=File.new(processed_data_path,"a+")
  processed_data_file<<date.to_s
  processed_data_file<<"#"+result_macd_array.to_s
  processed_data_file<<"#"+low_price_array.to_s
  processed_data_file<<"#"+high_price_array.to_s
  processed_data_file<<"#"+volume_array.to_s
  processed_data_file<<"\n"
  processed_data_file.close

end


def append_all_data
	table_file=File.expand_path("../../../resources/stock_list/stock_table_2013_10_01.txt",__FILE__)
    stock_list=load_stock_list_file(table_file)
    count=0

    stock_list.keys.each do |symbol|
    	 price_hash=get_price_hash_from_history(symbol)
         append_data(symbol,price_hash,0)
         count+=1
         puts "append count=#{count}"
    end
end

if $0==__FILE__

	symbol="000009.sz"
	price_hash=get_price_hash_from_history("000009.sz")

	#append first day data 
    append_data("000009.sz",price_hash,0)
    table_file=File.expand_path("../../../resources/stock_list/stock_table_2013_10_01.txt",__FILE__)
    stock_list=load_stock_list_file(table_file)
    count=0

  
end