require File.expand_path("../../data_process/read_daily_k.rb",__FILE__)

#仅仅用于统计和报告

def generate_price_will_up_down(price_hash,back_day)

	price_will_up_down=Hash.new
    #index 0  是最新
    price_array=price_hash.to_a


    today_price_array=price_array[back_day]
    if back_day>7
    after_three_days_price=price_array[back_day-7]
   else
	  after_three_days_price=price_array[back_day]
   end
  

   # print "today_price_array=#{today_price_array.to_s}"
   # print "after_three_days_price=#{after_three_days_price.to_s}"
  # print "today_price_array is nil!!"  if after_three_days_price.nil?

    #为简单起见，目前只加一个信号，先跑通整个框架，然后逐步加入更多想知道的
    #到底是+1还是-1？
    price_will_up_down["up_1_day"]= price_array[back_day][1][3].to_f>price_array[back_day-1][1][3].to_f

    price_will_up_down["up_10%_after_3_day"]= ((today_price_array[1][3].to_f-after_three_days_price[1][3].to_f)/after_three_days_price[1][3].to_f).round(2)>=0.05

	return  price_will_up_down
end

if $0==__FILE__
	price_hash=read_daily_k_file("000009.sz")
    generate_price_will_up_down(price_hash,1)
end