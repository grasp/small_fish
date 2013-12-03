require File.expand_path("../../../init/small_fish_init.rb",__FILE__)

=begin
 目录结构
 daily_k_one_day
  percent_3_num_7_days
    end_date_2013_12_31
      percent_95_count_10
        calculate_win
        buy_record
        potential_buy
      statistic
  win_lost_history
=end

def init_daily_k_report
	daily_k_one_day_folder=AppSettings.daily_k_one_day
	Dir.mkdir(daily_k_one_day_folder) unless File.exists?(daily_k_one_day_folder)

end

def report_one_day_daily_k
	
end

if $0==__FILE__

end