require File.expand_path("../../get_all_stock_name_table.rb",__FILE__)
def remove_empty_day_from_history_and_copy
	#symbol_file_orig=File.expand_path("../../../../resources/history_daily_data_2/#{symbol}.txt",__FILE__)
  	#symbol_file_processed=File.expand_path("../../../../resources/history_daily_data/#{symbol}.txt",__FILE__)

    stock_table=File.expand_path("../../../../resources/stock_list/stock_table_2013_10_01.txt",__FILE__)
    stock_list=load_stock_list_file(stock_table)
 
    count=0

    stock_list.keys.each do |symbol|
    	orig_content=File.read(File.expand_path("../../../../resources/history_daily_data_2/#{symbol}.txt",__FILE__)).split("\n")
    	symbol_file_processed=File.expand_path("../../../../resources/history_daily_data/#{symbol}.txt",__FILE__)

    	new_file=File.new(symbol_file_processed,"w+")

#最新的在最后面，最老的在前面，方便添加数据
      	orig_content.reverse.each do |line|
    		result=line.split(",")
    		result.shift(1)
    		new_file<<result.join("#") +"\n" unless line.match(",000,")
    	end
    	new_file.close
        count+=1
    	puts "#{symbol_file_processed} done,count=#{count}"
    end


end


if $0==__FILE__
#首先要下载到history_daily_data_2,然后再处理到history_daily_data
remove_empty_day_from_history_and_copy
end



