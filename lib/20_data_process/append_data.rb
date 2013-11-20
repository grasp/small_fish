require File.expand_path("../../../init/small_fish_init.rb",__FILE__)
require File.expand_path("../low_high_price_history.rb",__FILE__)
require File.expand_path("../macd_history.rb",__FILE__)
require File.expand_path("../volume_history.rb",__FILE__)

# 初次计算的值附加

def append_processed_data(symbol,price_array,back_day_array)

  processed_data_path=File.expand_path("./data_process/#{symbol}.txt","#{AppSettings.resource_path}")
  processed_data_file=File.new(processed_data_path,"a+")

  back_day_array.reverse.each do |back_day|
   # puts "handle backday=#{back_day},day_zero=#{price_array[0][0]}"
    low_high=low_high_price_array_on_backdays(price_array,back_day)

    low_price_array=low_high[0]
    high_price_array=low_high[1]

    result_macd_array=generate_macd_on_backday(price_array,back_day)
    volume_array=generate_volume_array_on_backday(price_array,back_day)
    date=price_array[back_day][0]
     # puts "price_array[back_day]=#{price_array[back_day]}"
    #puts "handle date=#{date}"

    processed_data_file<<date.to_s
    processed_data_file<<"#"+result_macd_array.to_s
    processed_data_file<<"#"+low_price_array.to_s
    processed_data_file<<"#"+high_price_array.to_s
    processed_data_file<<"#"+volume_array.to_s
    processed_data_file<<"\n"

end
    processed_data_file.close
end

def append_all_data
    count=0
    $all_stock_list.keys.each do |symbol|
     processed_data_path=File.expand_path("./data_process/#{symbol}.txt","#{AppSettings.resource_path}")
     next unless File.exists?(processed_data_path)
     count+=1
     puts "append #{symbol},count=#{count}"
    	  # price_hash=get_price_hash_from_history(symbol)
         append_diff_data(symbol)
    end
end


def get_diff_date(price_array,symbol)

  processed_data_path=File.expand_path("./data_process/#{symbol}.txt","#{AppSettings.resource_path}")

  contents=File.read(processed_data_path).split("\n")
  last_date= contents.last.match(/\d\d\d\d-\d\d-\d\d/).to_s
  back_day_array=[]

  0.upto(price_array.size).each do |index|

    if price_array[index][0]==last_date
      break
    else
      back_day_array<<index
     # price_array[index][0]
    end
end
#print  "back_day_array=#{back_day_array}"
back_day_array
end

def append_diff_data(symbol)
  price_hash=get_price_hash_from_history(symbol)
  price_array=price_hash.to_a


  back_day_array=get_diff_date(price_array,symbol)

  append_processed_data(symbol,price_array,back_day_array)

end

if $0==__FILE__

	symbol="000009.sz"
	#price_hash=get_price_hash_from_history("000009.sz")

	#append first day data 
  #  append_processed_data("000009.sz",price_hash,0)

#get_diff_date(symbol)
#append_diff_data(symbol)
  append_all_data
end