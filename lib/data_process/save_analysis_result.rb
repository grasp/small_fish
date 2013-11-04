
require File.expand_path("../macd_history.rb",__FILE__)
require  File.expand_path("../../data_collection/get_all_stock_name_table.rb",__FILE__)

require File.expand_path("../low_high_price_history.rb",__FILE__)
require File.expand_path("../volume_history.rb",__FILE__)

def save_analysis_result(symbol)

    result_file_path=File.expand_path("../../../resources/data_process/#{symbol}.txt",__FILE__)
    #analysis_result_file=File.new("#{symbol}.txt","w+")
    #puts result_file_path
    price_hash=get_price_hash_from_history(symbol)
    
    #倒序存放，方便append
    price_array=price_hash.to_a.reverse
     
     # 不处理没有价格数据的文件
    return -1 if  price_hash.size==0

    result_macd_hash=generate_one_stock_macd(price_hash)
    price_result=low_high_price_analysis(price_hash)

   # price_hash=macd_result[1]
    low_price_hash=price_result[0]
    high_price_hash=price_result[1]

    volume_hash=volume_analysis(price_hash)

    analysis_file=File.new(result_file_path,"w+")

   price_array.each_index do |index|
        date=price_array[index][0]
        analysis_file<<date
       # analysis_file<<"#"+price_hash[date].to_s
        analysis_file<<"#"+result_macd_hash[date].to_s
        analysis_file<<"#"+low_price_hash[date].to_s
        analysis_file<<"#"+high_price_hash[date].to_s
        analysis_file<<"#"+volume_hash[date].to_s
        analysis_file<<"\n"
    end
    analysis_file.close
    return 0
end

def test_save_one_analysy(symbol)
 save_analysis_result(symbol)
end

def save_all_analysis_result

    start=Time.now

    data_process_folder=File.expand_path("../../../resources/data_process",__FILE__)
    Dir.mkdir(data_process_folder) unless File.exists?(data_process_folder)

    table_file=File.expand_path("../../../resources/stock_list/stock_table_2013_10_01.txt",__FILE__)
    stock_list=load_stock_list_file(table_file)
    count=0
    stock_list.keys.each do |stock_id|
      result_file_path=File.expand_path("../../../resources/data_process/#{stock_id}.txt",__FILE__)

      unless File.exists?(result_file_path)
      result=save_analysis_result(stock_id) 
        count+=1
        puts "count=#{count},result=#{result}"
      end
    
    end
    puts "cost=#{Time.now - start}"
end





if $0==__FILE__
  save_analysis_result("000009.sz")
end