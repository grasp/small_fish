
require  File.expand_path("../../data_collection/get_all_stock_name_table.rb",__FILE__)
require  File.expand_path("../../signal_process/read_generated_signal.rb",__FILE__)
require  File.expand_path("../read_processed_signal.rb",__FILE__)
def buy_by_up_p10_after_several_days

end


if $0==__FILE__
	buy_by_up_p10_after_several_days
    will_key="up_p10_after_3_day"
    date="2013-10-31"

	table_file=File.expand_path("../../../resources/stock_list/stock_table_2013_10_01.txt",__FILE__)
    stock_list=load_stock_list_file(table_file)

    count=0
    stock_list.keys[1..2410].each do |stock_id|
      signal_file_path=File.expand_path("../../../resources/signal_gen/#{stock_id}.txt",__FILE__)
      signal_process_path=File.expand_path("../../../resources/signal_process/two/#{will_key}/#{stock_id}.txt",__FILE__)
      if File.exists?(signal_file_path)  && File.exists?(signal_process_path)
      	signal_array=read_signal_gen(stock_id)[1][date]
      	win_array=read_processed_signal(stock_id,will_key)
      	next if win_array.size==0
      	win_array.each do |array|
      		index_1=array[0].to_i
      		index_2=array[1].to_i
      		 puts "got buy chance on #{sotckid} on #{date}" if signal_array[index_1].to_s==array[2] && signal_array[index_2].to_s==array[3]
      	end

     end
   end
end