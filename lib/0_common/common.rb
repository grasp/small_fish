 require File.expand_path("../../../init/small_fish_init.rb",__FILE__)

 #计算day1和day2相差的天数，可以得到我们的backdays， 为计算某个区间的盈利测试
def get_diff_day(day1,day2)
     
   day_array1=day1.split("-")
   day_array2=  day2.split("-")

   # puts "day1=#{day1},day2=#{day2}"
    day1_time=Time.new(day_array1[0],day_array1[1],day_array1[2])
    day2_time=Time.new(day_array2[0],day_array2[1],day_array2[2])

  diff_time=(day1_time-day2_time).abs

 # puts "diff_time=#{diff_time}"
   # puts (diff_time/(60*60*24)).to_i
    (diff_time/(60*60*24)).to_i.abs  
end


def get_last_date_on_daily_k(symbol)
   source_file=File.expand_path("./history_daily_data/#{symbol}.txt","#{AppSettings.resource_path}")
    temp_file=File.new(source_file,"a+")
    last_line=temp_file.readlines[-1].to_s
   # puts "last_line=#{last_line}"
    last_date=last_line.match(/\d\d\d\d-\d\d-\d\d/)
    raise if last_date.nil?
    temp_file.close
   # puts "last_date=#{last_date}"
	last_date.to_s
end

def get_last_date_on_processed(symbol)
end

def get_last_signal_date(symbol)

end


if $0==__FILE__
	get_last_date_on_daily_k("000010.sz")
end