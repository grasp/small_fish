 require File.expand_path("../../../init/small_fish_init.rb",__FILE__)
 require File.expand_path("../0_single_signal_gen/highest_price_signal.rb")

def init_single_signal

	Dir.mkdir(AppSettings.single_signal) unless File.exists?(AppSettings.single_signal)
	#signal_name_folder=File.expand_path(signal_name,AppSettings.single_signal)
	#Dir.mkdir(signal_name_folder) unless File.exists?(signal_name_folder)
    init_generate_high_price_signal
    #generate_highest_price_signal

    $all_stock_list.keys.each do |symbol|
    	#unless File.exists?(File.expand_path("#{symbol}.txt"),signal_name_folder)
    	#	generate_single_signal_name()
    	#end
    end



end

#打印出single signal 
 def report_single_signal(signal_name)
     init_single_signal
 end

 if $0==__FILE__
 	init_single_signal
 end