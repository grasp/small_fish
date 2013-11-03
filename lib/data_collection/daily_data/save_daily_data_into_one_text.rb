require 'net/http' 
require File.expand_path("../../get_all_stock_name_table.rb",__FILE__)

def convert_to_sina_symbol(stock_id_array)
   new_stock_array=[]
   stock_id_array.each do |stock_id|
   sina_id=stock_id.split(".").reverse.join  if stock_id.match("sz")
   sina_id=stock_id.gsub("ss","sh").split(".").reverse.join  if stock_id.match("ss")
   new_stock_array<<sina_id
   end
   new_stock_array
end

def create_date_folder(date)
	daily_data_path=File.expand_path("../../../../resources/daily_data",__FILE__)
	#today=Time.now.to_s[0..9]
    Dir.mkdir(daily_data_path) unless File.exists?(daily_data_path)
	today_folder=File.join(daily_data_path,date)	#puts today_folder

	Dir.mkdir(today_folder) unless File.exists?(today_folder)
end

#依次为Date,开盘，最高，最低，收盘，成交量
def get_sina_real_time_data_without_proxy(stock_id)
   
	response= Net::HTTP.get("hq.sinajs.cn","/list=#{stock_id}" )
	result_array= response.split(",")

	yahoo_array=[]
	yahoo_array<< result_array[30]
    yahoo_array<< result_array[1]
    yahoo_array<< result_array[4]
    yahoo_array<< result_array[5]
    yahoo_array<< result_array[3]
    yahoo_array<< (result_array[8].to_i/100)
    yahoo_array<< result_array[3]
    yahoo_array

#begin
 # file = open("some_file")
#rescue
#  file = STDIN
#end
end


def combine_daily_data_from_sina(stock_id_array,date)
   
    totalsize=stock_id_array.size
	puts "stock id arrray size=#{stock_id_array.size}"

	sina_symbol_array=convert_to_sina_symbol(stock_id_array)
   
    daily_data_folder=daily_data_path=File.expand_path("../../../../resources/daily_data/#{date}",__FILE__)

    daily_txt="#{date}.txt"
    contents=""
    contents=File.read(File.join(daily_data_folder,daily_txt)) if File.exists?(File.join(daily_data_folder,daily_txt))
    daily_txt_file=File.new(File.join(daily_data_folder,daily_txt),"a+")
  counter=0
    sina_symbol_array.each do |stock_id|

       unless contents.match(stock_id)
       	counter+=1
       	yahoo_array=get_sina_real_time_data_without_proxy(stock_id)
       	yahoo_array.unshift(stock_id)
       	daily_txt_file<<yahoo_array.join("#")+"\n"
       	puts "done for #{stock_id} #{counter.to_f/totalsize}"
       end
    end

    daily_txt_file.close

end


def save_daily_data_into_one_text(date)
	 stock_list_file=File.expand_path("../../../../resources/stock_list/stock_table_2013_10_01.txt",__FILE__)
	 all_stock_list=load_stock_list_file(stock_list_file)
	 combine_daily_data_from_sina(all_stock_list.keys,date)
end



if $0==__FILE__

 start=Time.now

 #stock_list_file=File.expand_path("../../../resources/stock_list/stock_table_2013_10_01.txt",__FILE__)

 #all_stock_list=load_stock_list_file(stock_list_file)

date="2013-11-01"
create_date_folder(date)
save_daily_data_into_one_text(date)
puts "cost =#{Time.now-start}"
end