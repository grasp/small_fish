
require File.expand_path("../macd_signal.rb",__FILE__)
require File.expand_path("../low_price_signal.rb",__FILE__)
require File.expand_path("../high_price_signal.rb",__FILE__)
require File.expand_path("../open_signal.rb",__FILE__)
require File.expand_path("../volume_signal.rb",__FILE__)

def save_all_signal_to_file(symbol)
     #各种信号放到一起用于保存的Hash
	  save_hash={}

     #第一次数据分析以后的数据载入
     processed_data_array=read_full_data_process_file(symbol)
    
     #获取完成的价格hash
      price_hash=get_price_hash_from_history(symbol)

      #puts price_hash.to_a[1]

      #倒序？？ 为什么？？？
      full_price_array=price_hash.to_a.reverse


     full_macd_array=processed_data_array[0].to_a
     full_low_price_array=processed_data_array[1].to_a
     full_high_price_array=processed_data_array[2].to_a
     full_volume_array=processed_data_array[3].to_a

     #最新的日期在前面，index 为0， back_day的数据为0+back_day
     total_size=full_macd_array.size

     full_price_array.each_index do |index|

       	date=full_price_array[index][0]

       # print "#index #{index} date= #{date}"
        #puts date
        next if index==total_size-1
       # puts "macd"+full_macd_array[index][0]
        macd_signal_hash=judge_full_macd_signal(full_macd_array,index)
       # puts "low price"+full_low_price_array[index][0]
        low_price_signal_hash=low_price_signal(full_low_price_array,full_price_array,index)
        #puts "high"+full_high_price_array[index][0]

        high_price_signal_hash=high_price_signal(full_high_price_array,full_price_array,index)

        #puts "volume"+full_volume_array[index][0]
        volume_signal_hash=generate_volume_sigmal_by_full(full_volume_array,index)
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

def test_save_one_symbol(symbol)
  save_all_signal_to_file(symbol)
end

def test_save_all_signal
    table_file=File.expand_path("../../../resources/stock_list/stock_table_2013_10_01.txt",__FILE__)
    stock_list=load_stock_list_file(table_file)

    count=0
    stock_list.keys.each do |stock_id|
      result_file_path=File.expand_path("../../../resources/signal/#{stock_id}.txt",__FILE__)
        unless File.exists?(result_file_path)
         count+=1
         save_all_signal_to_file(stock_id)
         puts "count=#{count}"
        end
      end
end

if $0==__FILE__
   # test_save_all_signal
   test_save_one_symbol("000009.sz")
 end

