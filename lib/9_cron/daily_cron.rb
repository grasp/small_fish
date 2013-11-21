require File.expand_path("../../../init/small_fish_init.rb",__FILE__)
require File.expand_path("../../1_data_collection/daily_data/save_daily_data_into_one_text.rb",__FILE__)
require File.expand_path("../../1_data_collection/daily_data/append_daily_data_to_history.rb",__FILE__)
require File.expand_path("../../20_data_process/append_data.rb",__FILE__)
require File.expand_path("../../30_signal_gen/append_signal.rb",__FILE__)

#需要对其这几个文件的最后一行的日期才可以做以下的操作，需要做更多的健壮性代码
def daily_data_cron

save_today_daily_data

result=appened_today_daily_data
puts "appened_today_daily_data result=#{result}"

if result==0
  append_all_data_process
  append_all_signal
end


end

if $0==__FILE__
	daily_cron
end