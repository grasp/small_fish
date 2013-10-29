require File.expand_path("../../data_process/read_daily_k.rb",__FILE__)

#仅仅用于统计和报告

def generate_price_will_up_down(price_hash,back_day)

	price_will_up_down=Hash.new
    #index 0  是最新
    price_array=price_hash.to_a
    
    #为简单起见，目前只加一个信号，先跑通整个框架，然后逐步加入更多想知道的
    price_will_up_down["up_1_day"]= price_array[back_day][1][3].to_f>price_array[back_day+1][1][3].to_f
	return  price_will_up_down
end

if $0==__FILE__
	price_hash=read_daily_k_file("000009.sz")
    generate_price_will_up_down(price_hash,1)
end