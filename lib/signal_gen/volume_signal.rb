require File.expand_path("../read_data_process.rb",__FILE__)
require File.expand_path("../../../init/config_load.rb",__FILE__)
require  File.expand_path("../../data_collection/get_all_stock_name_table.rb",__FILE__)

def generate_volume_signal(full_volume_array, back_day)

	 volume_signal=Hash.new
	 volume_array=full_volume_array[back_day][1]
     volume_signal["volume1_bigger_volume2"]=(volume_array[0].to_f > volume_array[1].to_f) 
     volume_signal["volume2_bigger_volume3"]=(volume_array[1].to_f > volume_array[2].to_f) 
     volume_signal["volume2_bigger_volume5"]=(volume_array[1].to_f > volume_array[4].to_f) 
  	 volume_signal["volume5_bigger_volume10"]= (volume_array[4].to_f > volume_array[5].to_f) 
     volume_signal["volume5_bigger_volume20"]= (volume_array[4].to_f > volume_array[6].to_f) 
     volume_signal["volume5_bigger_volume30"]= (volume_array[4].to_f > volume_array[7].to_f) 
     volume_signal["volume5_bigger_volume60"]= (volume_array[4].to_f > volume_array[8].to_f) 
     volume_signal["volume5_bigger_volume100"]= (volume_array[4].to_f > volume_array[9].to_f) 
     volume_signal
end


def generate_full_volume_signal(symbol)
	 #用于保存的Hash
	 save_hash={}

     #第一次数据分析以后的数据载入
     processed_data_array=read_data_process_file(symbol)

     #获取完成的价格hash
     full_price_array=processed_data_array[0].to_a

     #print full_price_array
     #low_price_hash=processed_data_array[2]

     full_volume_array=processed_data_array[4].to_a
    # print "back day 0 ="+full_low_price_array[0][0].to_s
     total_size=full_volume_array.size

     full_volume_array.each_index do |index|
     	  next if index==total_size-1
     	 # print "index=#{index}"
     	#print "index#{index}="+full_low_price_array[index].to_s
     	date=full_volume_array[index][0]
      
        signal_hash=generate_volume_signal(full_volume_array,index)
        save_hash[date]=signal_hash
     end

save_hash
end

if $0==__FILE__
   print generate_full_volume_signal("000009.sz")
end