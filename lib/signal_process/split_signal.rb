require File.expand_path("../cal_common.rb",__FILE__)
require File.expand_path("../read_signal_process.rb",__FILE__)
require File.expand_path("../../data_process/read_daily_k.rb",__FILE__)
require File.expand_path("../../signal_gen/price_will_up_down_signal.rb",__FILE__)

def split_signal_by_will_key(symbol,will_key)

	signal_result=read_signal_process(symbol)
	signal_array=signal_result[1]
	signal_keys=signal_result[0]
	price_hash=read_daily_k_file(symbol)
	win_signal_array=[]
	win_lost_array=[]

 signal_array.each_index do |back_days|
	if generate_price_will_up_down(price_hash,back_days)[will_key]==true
	  win_signal_array << signal_array[back_days]
	 # print signal_array[back_days].to_s+"\n"
	else
		win_lost_array<<signal_array[back_days]
    end  
 end
    [signal_keys,win_signal_array,win_lost_array]
end





if $0==__FILE__
	symbol="000009.sz"
	result=get_signal_for_1_day_up(symbol)
	guess_policy(result[0],result[1],result[2])
end