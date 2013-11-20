
require File.expand_path("../../../../init/small_fish_init.rb",__FILE__)
require "json"
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
    #print result.to_s+"\n"
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
 
  	yahoo_data_hash[new_key]=value
  end


    yahoo_data_hash.each do |key,value|
    	symbol=key
      new_array=value
      new_array[4]=((value[4].to_i)*100).to_s #sina and yahoo is different
    #	puts "start #{symbol},#{value[4]},#{new_array[4]}"
    	history_data_path=File.expand_path("./history_daily_data/#{symbol}.txt","#{AppSettings.resource_path}")

    	#防止重复写入同一天数据到历史文件
    if File.exists?(history_data_path)
    	unless File.read(history_data_path).match(value[0])
    	  history_data_file=File.new(history_data_path,"a+")
    	  history_data_file<<new_array.join("#")+"\n"
    	  history_data_file.close
      end
    end
    end

end

def appened_today_data
  today=Time.now.to_s[0..9]
  append_daily_data_into_history(today)
end


if $0==__FILE__
    start=Time.now
	#  append_daily_data_into_history("2013-11-20")
    appened_today_data
    puts "cost #{Time.now-start}"
end