require "pathname"
require 'test/unit'
include Test::Unit::Assertions

lib_path=Pathname.new(__FILE__).parent.parent
#require File.join(lib_path,"init","redis_init.rb")
#require File.join(lib_path,"utility","get_all_stock_name_table.rb")
#require File.join(lib_path,"init","stock_list_init.rb")

require File.expand_path("../../get_all_stock_name_table.rb",__FILE__)



def download_one_stock_history_data_from_yahoo(symbol,days)
  lib_path=Pathname.new(__FILE__).parent.parent
  exe_path=File.expand_path("../../yahoo/yahoofinance.rb",__FILE__)

  command_run="ruby #{exe_path} -z -d #{days} #{symbol}"
  result=`#{command_run}`
  raise if result.size.nil?
  #store to file  
  #symbole_file_name=File.join(lib_path.parent,"history_daily_data","#{symbol}.txt")
  symbole_file_name=File.expand_path("../../../../resources/history_daily_data_2/#{symbol}.txt",__FILE__)

  puts symbole_file_name
  symbol_file=File.new(symbole_file_name,"w")
  symbol_file << result
    symbol_file.close
end

def download_all_symbol_into_history_data(days)

stock_table=File.expand_path("../../../../resources/stock_list/stock_table_2013_10_01.txt",__FILE__)
stock_list=load_stock_list_file(stock_table)
count=0
stock_list.keys.each do |symbol|
count+=1
puts "count=#{count}"
 download_one_stock_history_data_from_yahoo(symbol,days)
 #等待8 second 一下，避免访问太多后，不能使用
 sleep 8
end
end

def update_for_not_downloaded(days)

stock_table=File.expand_path("../../../../resources/stock_list/stock_table_2013_10_01.txt",__FILE__)
stock_list=load_stock_list_file(stock_table)

count=0
stock_list.keys.each do |symbol|
symbole_file_name=File.expand_path("../../../../resources/history_daily_data_2/#{symbol}.txt",__FILE__)

if  File.stat(symbole_file_name).size < 2000
  download_one_stock_history_data_from_yahoo(symbol,days)
  count+=1
  sleep 15
  puts "count=#{count}" 
end

end

end


#only run if test this file
if $0 == __FILE__
#get_one_stock_history_data("601566.ss")
#stock_list_file="G:\\small_fish_0\\info\\stock_table_2013_10_01.txt"
#download_all_history_data_from_file(stock_list_file)

#download_one_stock_history_data_from_yahoo("000002.sz",10000)

#download_all_symbol_into_history_data(10000)
update_for_not_downloaded(10000)

end