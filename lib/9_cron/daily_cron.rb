require File.expand_path("../../../init/small_fish_init.rb",__FILE__)
require File.expand_path("../../1_data_collection/daily_data/save_daily_data_into_one_text.rb",__FILE__)
require File.expand_path("../../1_data_collection/daily_data/append_daily_data_to_history.rb",__FILE__)
require File.expand_path("../../20_data_process/append_data.rb",__FILE__)
require File.expand_path("../../30_signal_gen/append_signal.rb",__FILE__)
require File.expand_path("../../0_common/common.rb",__FILE__)


#需要对其这几个文件的最后一行的日期才可以做以下的操作，需要做更多的健壮性代码
def daily_data_cron

last_date1=get_last_date_on_daily_k("000009.sz").to_s
last_date2=get_last_date_on_daily_k("000008.sz").to_s
raise if last_date1!=last_date2#TBD

today=Time.now.to_s[0..9]
return 0 if today==last_date1



# 必须顺序附加，节假日就麻烦了，呵呵
diff_day=get_diff_day(today,last_date1)
puts "today=#{today},last_date=#{last_date1},diff_day=#{diff_day}"
Time.now.monday? ? max_diff_day=3 : max_diff_day=1
target_file=File.expand_path("./daily_data/#{today}.txt","#{AppSettings.resource_path}")

#如果还没下载
if (not File.exists?(target_file)) && Time.now.hour>15
  save_today_daily_data
end

if File.exists?(target_file) && (diff_day==max_diff_day) && (today > last_date1) && (not Time.now.sunday?) && (not Time.now.saturday?)

  result=appened_today_daily_data
  puts "appened_today_daily_data result=#{result}"

  if result==0
    append_all_data_process
    append_all_signal
  end

else
	puts "did not append any data as condition not true"
end
end

if $0==__FILE__
	daily_data_cron
end