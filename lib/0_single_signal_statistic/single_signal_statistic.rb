require File.expand_path("../../../init/small_fish_init.rb",__FILE__)
require File.expand_path("../../20_data_process/read_daily_price_volume.rb",__FILE__)


def single_signal_statistic(end_date,sell_strategy)
  Dir.mkdir(AppSettings.single_signal_statistic) unless File.exists?(AppSettings.single_signal_statistic)
  end_date_folder=File.expand_path("./#{end_date}",AppSettings.single_signal_statistic)
  raise unless File.exists?(AppSettings.single_signal)

  Dir.mkdir(end_date_folder) unless File.exists?(end_date_folder)
   win_lost_folder=AppSettings.win_lost
#创建signal folder
  Dir.new(AppSettings.single_signal).each do |signal_folder|
  	unless (signal_folder =="." ||signal_folder =="..")
  	sub_folder=File.expand_path(signal_folder,AppSettings.single_signal)
  	statistic_folder=File.expand_path("./#{signal_folder}",end_date_folder)
  	puts sub_folder

  	Dir.mkdir(statistic_folder) unless File.exists?(statistic_folder)

  	Dir.new(win_lost_folder).each do |percent_folder|
  		unless (percent_folder =="." ||percent_folder =="..")
  			puts percent_folder
  			statistic_percent_folder=File.expand_path(percent_folder,statistic_folder)
  			Dir.mkdir(statistic_percent_folder)  unless File.exists?(statistic_percent_folder)
  			sell_strategy_folder=File.expand_path("./#{sell_strategy}",statistic_percent_folder)
  			Dir.mkdir(sell_strategy_folder) unless File.exists?(sell_strategy_folder)

  			signal_source_file=""
  			win_lost_signal_file=""
  			target_statistic_file=""

  		end
  	end
  end
end
end


 def statistic_by_file(signal_source,win_lost_file,target_statitic_file)

 end


#为每一个 sell_strategy 生成统计

#end

if $0==__FILE__
    signal_source_file="e:\single_signal\close_equal_high\000009.sz.txt"
  	win_lost_signal_file="e:\win_lost\percent_1_num_7_days\buy_by_close_sell_by_close\000009.sz.txt"
  	target_statistic_file="e:\single_signal_statistic\2013-12-31\close_equal_high\percent_1_num_7_days\buy_by_close_sell_by_close\000009.sz.txt"

	#single_signal_statistic("2013-12-31","buy_by_close_sell_by_close")
	statistic_by_file(signal_source_file,win_lost_signal_file,target_statistic_file)
end