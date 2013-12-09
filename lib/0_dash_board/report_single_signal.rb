 require File.expand_path("../../../init/small_fish_init.rb",__FILE__)
 require File.expand_path("../0_single_signal_gen/highest_price_signal.rb")
 require File.expand_path("../0_single_signal_gen/lowest_price_signal.rb")
 require File.expand_path("../0_single_signal_gen/open_signal.rb")
 require File.expand_path("../0_single_signal_gen/sma_signal.rb")
 require File.expand_path("../0_single_signal_gen/volume_signal.rb")
 require File.expand_path("../0_win_lost/win_lost.rb")


def init_report_single_signal

	Dir.mkdir(AppSettings.single_signal) unless File.exists?(AppSettings.single_signal)

    generate_high_price_signal_for_all_symbol(false)
    generate_low_price_signal_for_all_symbol(false)
    generate_open_signal_for_all_symbol(false)  
    generate_sma_signal_for_all_symbol(false)
    generate_volume_signal_for_all_symbol(false)
    
    sell_strategy="buy_by_close_sell_by_close"
    regeneration_flag=true

    init_win_lost
    generate_all_percent_number_day_zuhe(sell_strategy,regeneration_flag)

end

#打印出single signal 
 def report_single_signal(signal_name)
     init_single_signal
 end

 if $0==__FILE__
 	init_report_single_signal
 end