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
#注意，win signal array 没有key, 是以index作为下标
    [signal_keys,win_signal_array,win_lost_array]
end





if $0==__FILE__
symbol="000009.sz"
split_signal_by_will_key("000009.sz","up_1_day")
end
