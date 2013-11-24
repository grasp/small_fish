require File.expand_path("../../../init/small_fish_init.rb",__FILE__)
require File.expand_path("../../0_common/common.rb",__FILE__)

def check_price_file_consistent_for_last_line
	unconsistent_counter=0
    counter_hash=Hash.new{0}
	$all_stock_list.keys.each do |symbol|
	  source_file=File.expand_path("./history_daily_data/#{symbol}.txt","#{AppSettings.resource_path}")
	  if File.exists?(source_file) && File.stat(source_file).size>0
	  	 last_date=get_last_date_on_daily_k(symbol).to_s
	  	 counter_hash[last_date]+=1
	  end
	end
	$logger.info("price file consistent =#{counter_hash}")
    puts counter_hash
	puts counter_hash.size
end

def check_data_process_file_consistent_for_last_line
	unconsistent_counter=0
    counter_hash=Hash.new{0}
	$all_stock_list.keys.each do |symbol|
	  source_file=File.expand_path("./data_process/#{symbol}.txt","#{AppSettings.resource_path}")
	  if File.exists?(source_file) && File.stat(source_file).size>0
	  	 last_date=get_last_date_on_daily_k(symbol).to_s
	  	 counter_hash[last_date]+=1
	  end
	end
	$logger.info("data process consistent =#{counter_hash}")
    puts counter_hash
	puts counter_hash.size
end

def check_signal_gen_file_consistent_for_last_line
	unconsistent_counter=0
    counter_hash=Hash.new{0}
	$all_stock_list.keys.each do |symbol|
	  source_file=File.expand_path("./signal/#{symbol}.txt","#{AppSettings.resource_path}")
	  if File.exists?(source_file) && File.stat(source_file).size>0
	  	 last_date=get_last_date_on_daily_k(symbol).to_s
	  	 counter_hash[last_date]+=1
	  end
	end

	$logger.info("signal consistent=#{counter_hash}")
    puts counter_hash
	puts counter_hash.size
end

def check_consistent_on_date()

end

def check_consistent(symbol)
   price_data=File.expand_path("./history_daily_data/#{symbol}.txt","#{AppSettings.resource_path}")
   data_processed=File.expand_path("./data_process/#{symbol}.txt","#{AppSettings.resource_path}")
   signal_gen=File.expand_path("./signal/#{symbol}.txt","#{AppSettings.resource_path}")

   last_date1=get_last_date_on_daily_k(symbol).to_s
   last_date2=get_last_date_on_file(data_processed)
   last_date3=get_last_date_on_file(signal_gen)
   result=[last_date1,last_date2,last_date3]
   $logger.info("#{symbol} price,process,signal last date =#{result}")
   return result
end

if $0==__FILE__
	#puts check_consistent("300336.sz")
	puts check_price_file_consistent_for_last_line
	check_data_process_file_consistent_for_last_line
	check_signal_gen_file_consistent_for_last_line
end