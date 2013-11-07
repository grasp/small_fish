
require  File.expand_path("../../signal_process/read_generated_signal.rb",__FILE__)
require  File.expand_path("../read_processed_signal.rb",__FILE__)
def buy_by_up_p10_after_several_days

end


if $0==__FILE__
	buy_by_up_p10_after_several_days
    will_key="up_p10_after_3_day"
    date="2013-11-01"

    count=0
    $all_stock_list.keys[1..2410].each do |stock_id|
 
      signal_file_path=File.expand_path("./signal/#{stock_id}.txt","#{AppSettings.resource_path}")
      signal_process_path=File.expand_path("./signal_process/two/#{will_key}/#{stock_id}.txt","#{AppSettings.resource_path}")
      if File.exists?(signal_file_path)  && File.exists?(signal_process_path)
         # print stock_id
      	signal_array=read_signal_gen(stock_id)[1][date]
      	win_array=read_processed_signal(stock_id,will_key)
        puts "#{stock_id} is nil" if signal_array.nil?
      	next if signal_array.nil?
      	win_array.each do |array|
      		index_1=array[0].to_i
      		index_2=array[1].to_i
         # print "signal_array[index_1]=#{signal_array[index_1]},array[2]=#{array[2]}\n"
         # print "signal_array[index_2]=#{signal_array[index_2]},array[3]=#{array[3]}\n"
      		 puts "got buy chance on #{stock_id} on #{date}" if signal_array[index_1].to_s==array[2] && signal_array[index_2].to_s==array[3]

        end
         else
         # puts "ignore #{stock_id}"
     end
   end
end