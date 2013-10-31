require File.expand_path("../read_data_process.rb",__FILE__)
require File.expand_path("../../../init/config_load.rb",__FILE__)
require  File.expand_path("../../data_collection/get_all_stock_name_table.rb",__FILE__)

def high_price_signal(full_high_price_array,full_price_array,back_day)
	high_price_signal_hash=Hash.new

	high_price_array=full_high_price_array[back_day]
	price_array=full_price_array[back_day]
	#print high_price_array.to_s+"\n"
	#print "price_array="+price_array.to_s+"\n"

    high_price_signal_hash["highest_5_day"]= (high_price_array[1][4].to_f > price_array[1][3].to_f) 
    high_price_signal_hash["highest_10_day"]= (high_price_array[1][5].to_f > price_array[1][3].to_f) 
    high_price_signal_hash["highest_20_day"]= (high_price_array[1][6].to_f > price_array[1][3].to_f)
    high_price_signal_hash["highest_30_day"]= (high_price_array[1][7].to_f > price_array[1][3].to_f) 
    high_price_signal_hash["highest_60_day"]= (high_price_array[1][8].to_f > price_array[1][3].to_f) 
    high_price_signal_hash["highest_100_day"]= (high_price_array[1][9].to_f > price_array[1][3].to_f) 
    high_price_signal_hash["highest_120_day"]= (high_price_array[1][10].to_f > price_array[1][3].to_f) 
	return high_price_signal_hash
end


def generate_all_high_price_signal(symbol)
	 #用于保存的Hash
	 save_hash={}

     #第一次数据分析以后的数据载入
     processed_data_array=read_data_process_file(symbol)

     #获取完成的价格hash
     full_price_array=processed_data_array[0].to_a

     #print full_price_array
     low_price_hash=processed_data_array[2]
     full_high_price_array=low_price_hash.to_a
    # print "back day 0 ="+full_low_price_array[0][0].to_s
     total_size=full_high_price_array.size

     full_high_price_array.each_index do |index|
     	  next if index==total_size-1
     	 # print "index=#{index}"
     	#print "index#{index}="+full_high_price_array[index].to_s
     	date=full_high_price_array[index][0]
      
        signal_hash=high_price_signal(full_high_price_array,full_price_array,index)
        save_hash[date]=signal_hash
     end

save_hash
end

if $0==__FILE__
  generate_all_high_price_signal("000009.sz")
end