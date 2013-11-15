require File.expand_path("../../data_process/read_daily_price_volume.rb",__FILE__)
#hash 的值为几个基本数据，依次为开盘，最高，最低，收盘，成交量
def generate_daily_k_signal_one_day(symbol)
    price_hash=get_price_hash_from_history(symbol)
    price_hash.each do |date,array|
    	next if array[0]==0
    	next if array.size<3

    	#puts date
    	#print array.to_s+"\n"
    	 win=array[3].to_f-array[0].to_f

    	 if win > 0
    	 	 #up=array[3].to_f
    	 	 #down=array[0].to_f
    	 	 shang_ying=array[1].to_f-array[3].to_f
    	     xia_ying=down=array[0].to_f-array[2].to_f

    	 else
             shang_ying=array[1].to_f-array[0].to_f
    	     xia_ying=down=array[3].to_f-array[2].to_f

    	 end
    	 total_lenth=array[1].to_f-array[2].to_f
  
    	# shang_ying=array[1].to_f-up
    	 #xia_ying=down-array[3].to_f

    	 win_percent=((win/total_lenth)*10).round(0)
    	 shang_ying_percent=((shang_ying/total_lenth)*10).round(0)
         xia_ying_percent=((xia_ying/total_lenth)*10).round(0)
    	 zheng_fu_percent=((total_lenth/array[0].to_f)*10).round(0)
          puts  "#{win_percent},#{zheng_fu_percent},#{shang_ying_percent},#{xia_ying_percent}"
    end

end

if $0==__FILE__
	 generate_daily_k_signal_one_day("000009.sz")


end