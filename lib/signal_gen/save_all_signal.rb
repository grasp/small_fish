
require File.expand_path("../macd_signal.rb",__FILE__)
require File.expand_path("../low_price_signal.rb",__FILE__)
require File.expand_path("../high_price_signal.rb",__FILE__)
require File.expand_path("../open_signal.rb",__FILE__)
require File.expand_path("../volume_signal.rb",__FILE__)

def save_all_signal_to_file(symbol)
     #各种信号放到一起用于保存的Hash
	  save_hash={}

     #第一次数据分析以后的数据载入
     processed_data_array=read_data_process_file(symbol)

     #获取完成的价格hash
     price_hash=processed_data_array[0]
     full_price_array=price_hash.to_a
     full_macd_array=processed_data_array[1].to_a
     full_low_price_array=processed_data_array[2].to_a
     full_high_price_array=processed_data_array[3].to_a
     full_volume_array=processed_data_array[4].to_a

     #最新的日期在前面，index 为0， back_day的数据为0+back_day
     full_macd_array=processed_data_array[1].to_a
     total_size=full_macd_array.size

     full_price_array.each_index do |index|
       	date=full_price_array[index][0]
        next if index==total_size-1
        macd_signal_hash=judge_macd_signal(full_macd_array,index)
        low_price_signal_hash=low_price_signal(full_low_price_array,full_price_array,index)
        high_price_signal_hash=high_price_signal(full_high_price_array,full_price_array,index)
        volume_signal_hash=generate_volume_signal(full_volume_array,index)
        open_signal=generate_open_signal(full_price_array,index)
        save_hash[date]=macd_signal_hash.merge(low_price_signal_hash).merge(high_price_signal_hash).merge(volume_signal_hash).merge(open_signal)
     end

  signal_file_path=File.expand_path("../../../resources/signal/#{symbol}.txt",__FILE__)
  first_line_flag=true
  #puts signal_file_path
  signal_file=File.new(signal_file_path,"w+")

  save_hash.each do |date,s_hash|
    signal_file<< s_hash.keys.to_s+"\n"   if first_line_flag==true
    signal_file<<date
    signal_file<<s_hash.values.to_s+"\n"

    first_line_flag=false
  
  end
  #puts save_hash
  signal_file.close


end

if $0==__FILE__
   symbol="000009.sz"
   save_all_signal_to_file(symbol)
end