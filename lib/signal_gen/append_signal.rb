require File.expand_path("../macd_signal.rb",__FILE__)
require File.expand_path("../low_price_signal.rb",__FILE__)
require File.expand_path("../high_price_signal.rb",__FILE__)
require File.expand_path("../open_signal.rb",__FILE__)
require File.expand_path("../volume_signal.rb",__FILE__)
require File.expand_path("../../data_process/read_daily_price_volume.rb",__FILE__)


#back day 0表示最新的一天
def append_signal(symbol,back_day)

	processed_data=File.expand_path("./data_process/#{symbol}.txt","#{AppSettings.resource_data}")

    contents_array=File.read(processed_data).split("\n").reverse
 
    price_hash=get_price_hash_from_history(symbol)
    full_price_array=price_hash.to_a

    date=full_price_array[back_day][0]

    #print full_price_array[0]

    puts "full_price_array[0]=#{full_price_array[0]}"

    result_data=contents_array[back_day].split("#")
    t_macd_array=result_data[1].gsub(/\[|\]/,"").split(",")
    last_macd_array=contents_array[back_day+1].split("#")[1].gsub(/\[|\]/,"").split(",")

    #print  t_macd_array
   # print last_macd_array

    low_price_array=result_data[2].gsub(/\[|\]/,"").split(",")
    high_price_array=result_data[3].gsub(/\[|\]/,"").split(",")
    volume_array=result_data[4].gsub(/\[|\]/,"").split(",")

    macd_signal_hash=judge_macd_signal(t_macd_array,last_macd_array,back_day)
	high_price_signal_hash=generate_high_price_signal_on_backday(high_price_array,full_price_array,back_day)
    low_price_signal_hash=generate_low_price_signal_on_backday(low_price_array,full_price_array,back_day)
    volume_signal_hash=generate_volume_signal_on_backday(volume_array,back_day)
    open_signal=generate_open_signal(full_price_array,0)

#这个顺序必须和save all signal里面的一样，否则就乱套了
    result_hash=macd_signal_hash.merge(low_price_signal_hash).merge(high_price_signal_hash).merge(volume_signal_hash).merge(open_signal)


#加入到文件中
   signal_file_path=File.expand_path("./signal/#{symbol}.txt","#{AppSettings.resource_data}")
   signal_file=File.new(signal_file_path,"a+")
   signal_file<<date.to_s+result_hash.values.to_s+"\n"
   signal_file.close

end

if $0==__FILE__
    symbol="000009.sz"

    #获取完成的价格hash
    price_hash=get_price_hash_from_history(symbol)
	print append_signal(symbol,0)
end