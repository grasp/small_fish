
require File.expand_path("../../../../init/small_fish_init.rb",__FILE__)
def append_daily_data_into_history(date)
  sina_data_hash=Hash.new
  yahoo_data_hash=Hash.new
 # folder_path=File.expand_path("./daily_data/#{date}","#{AppSettings.resource_path}")

  daily_data_path=File.expand_path("./daily_data/#{date}.txt","#{AppSettings.resource_path}")

  puts daily_data_path
  raise unless File.exists?(daily_data_path)

  contents_array=File.read(daily_data_path).split("\n")
  count=0
  contents_array.each do |daily_data|
    count+=1
    puts "count=#{count}"
  	result=daily_data.split("#")
  	#result[0] 是代号

  	key=result[0]
  	result.shift(1)
  	#print result
    sina_data_hash[key]=result
  end

  #转换成yahoo格式
  sina_data_hash.each do |key,value|
  	#puts key
  	new_key=key[2..8]+".ss" if key.match("sh")
  	new_key=key[2..8]+".sz" if key.match("sz")
  	#print new_key
  	yahoo_data_hash[new_key]=value
  end


    yahoo_data_hash.each do |key,value|
    	symbol=key
    	#puts "start #{symbol}"
    	history_data_path=File.expand_path("./history_daily_data/#{symbol}.txt","#{AppSettings.resource_path}")

    	#防止重复写入同一天数据到历史文件
    	unless File.read(history_data_path).match(value[0])
    	  history_data_file=File.new(history_data_path,"a+")
    	  history_data_file<<value.join("#")+"\n"
    	  history_data_file.close
      end
    end

end


if $0==__FILE__
    start=Time.now
	  append_daily_data_into_history("2013-11-08")
    puts "cost #{Time.now-start}"
end