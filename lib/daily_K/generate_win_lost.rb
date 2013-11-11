
require File.expand_path("../../data_process/read_daily_price_volume.rb",__FILE__)

#判断number day内将会涨跌
def generate_win_lost_on_backday(price_hash,will_key,back_day,percent, number_day)

    #最后几天统计不能算，因为此时我们还不能知道是否盈利或者亏损，只能计算到倒数几天，因此原来的计算有误，需要重新计算
	raise if back_day<number_day

    #price_hash=get_price_hash_from_history("000009.sz")

    true_false=true
    
    future_price_array=[]
    1.upto(number_day).each do |i|
    	number_day <<price_array[back_day-i][1][3].to_f
    end


    #index 0  是最新
    price_array=price_hash.to_a
    today_price_array=price_array[back_day]
    today_price=today_price_array[1][3]

1.upto(number_day).each do |i|
	true_false||=((price_array[back_day-i][1][3].to_f-today_price)/today_price)>=percent
end

return true_false

end


if $0==__FILE__

	symbol="000009.sz"

	price_hash=get_price_hash_from_history("000009.sz")
	size=price_hash.size

     generate_win_lost_on_backday(price_hash,"",10,0.03,5)

end