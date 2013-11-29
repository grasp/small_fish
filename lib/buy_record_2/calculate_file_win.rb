require File.expand_path("../../20_data_process/read_daily_price_volume.rb",__FILE__)
require File.expand_path("../../30_signal_gen/price_will_up_down_signal.rb",__FILE__)

def calculate_file_win(folder,date)

	source_file=File.expand_path("./buy_record/#{folder}/#{date}.txt","#{AppSettings.resource_path}")
    contents=File.read(source_file).split("\n")
   #puts contents
    true_counter=0
    false_counter=0
    contents.each do |line|
      next if line.nil?
      symbol=line.split("#")[0].gsub(".txt","")
       win_lost_file=File.expand_path("./win_lost/#{folder}/#{symbol}.txt","#{AppSettings.resource_path}")
       win_lost=File.read(win_lost_file)
      result=win_lost.match(/#{date}.*\n/).to_s
      true_counter+=1 if result.match("true")
      false_counter+=1 if result.match("false")
    end

   puts "percent on #{date} = #{true_counter.to_f/(true_counter+false_counter)}"
end

if $0==__FILE__
	folder="percent_3_num_7_days"

30.downto(1).each do |i|
  date = Date.new(2013, 11, -i)
 # d -= (d.wday - 5) % 7
 # puts date
  unless (date.wday==6 || date.wday==0)
  	puts date
	calculate_file_win(folder,date)
  end
end
end