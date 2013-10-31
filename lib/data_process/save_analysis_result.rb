
require File.expand_path("../macd_history.rb",__FILE__)
require  File.expand_path("../../data_collection/get_all_stock_name_table.rb",__FILE__)

require File.expand_path("../low_high_price_history.rb",__FILE__)
require File.expand_path("../volume_history.rb",__FILE__)

def save_analysis_result(symbol)

    file_path=File.expand_path("../../../resources/analysis_result/#{symbol}.txt",__FILE__)
    #analysis_result_file=File.new("#{symbol}.txt","w+")
    #puts file_path
    raw_hash=read_daily_k_file(symbol)
    macd_result=generate_one_stock_macd(raw_hash)
    price_result=low_high_price_analysis(raw_hash)

    result_macd_hash=macd_result[0]
    price_hash=macd_result[1]
    low_price_hash=price_result[0]
    high_price_hash=price_result[1]

    volume_hash=volume_analysis(raw_hash)

    analysis_file=File.new(file_path,"w+")
    result_macd_hash.each do |date,macd_array|
        analysis_file<<date.to_s
        analysis_file<<"#"+price_hash[date].to_s
        analysis_file<<"#"+macd_array.to_s
        analysis_file<<"#"+low_price_hash[date].to_s
        analysis_file<<"#"+high_price_hash[date].to_s
        analysis_file<<"#"+volume_hash[date].to_s
        analysis_file<<"\n"
    end
    analysis_file.close
end



if $0==__FILE__
	save_analysis_result("000009.sz")

      #This file is search from TongHuaShun software installed folder
  #table_file=File.expand_path("../../../resources/stock_list/stock_table_2013_10_01.txt",__FILE__)
 # assert(File.exist?(table_file),"#{table_file} not exist!")

  #stock_list=load_stock_list_file_into_redis(table_file)

   # stock_list.keys[0..100].each do |stockid|
    #save_analysis_result(stockid)
#end
end