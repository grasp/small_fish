require File.expand_path("../../../../init/small_fish_init.rb",__FILE__)

def append_history_data(symbol)

	raw_data_path=File.expand_path("./history_daily_data_3/#{symbol}.txt","#{AppSettings.resource_path}")
	exsisted_data=File.expand_path("./history_daily_data/#{symbol}.txt","#{AppSettings.resource_path}")

    raw_data_contents=File.read(raw_data_path).split("\n")
    exsisted_data_contents=File.read(exsisted_data)


    temp_file=File.new(exsisted_data,"a+")
	last_line=temp_file.readlines[-2..-1].to_s

   last_date=last_line.match(/\d\d\d\d-\d\d-\d\d/).to_s
   #raise if raw_data_contents.to_s.match(last_date)
   
   raw_data_contents.reverse.each do |line|
		  a=line.match(/\d\d\d\d-\d\d-\d\d/).to_s
		   result=line.split(",")
    		result.shift(1)
    		#puts "result=#{result}"
    		temp_file<<result.join("#") +"\n" if (not exsisted_data_contents.match(a)) && result.size>3 #防止重复记录
	end

		temp_file.close


end

def append_all_history_data
   count=0
	$all_stock_list.keys.each do |symbol|
	  count+=1
	  puts "#{symbol},count=#{count}"
	  raw_data_path=File.expand_path("./history_daily_data_3/#{symbol}.txt","#{AppSettings.resource_path}")
	  exsisted_data=File.expand_path("./history_daily_data/#{symbol}.txt","#{AppSettings.resource_path}")
		
		if File.exists?(raw_data_path) && File.exists?(exsisted_data)
          append_history_data(symbol)
        end
    end
end


if $0==__FILE__

append_all_history_data
#append_history_data("000009.sz")
end