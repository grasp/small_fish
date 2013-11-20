require File.expand_path("../../../init/small_fish_init.rb",__FILE__)
require 'json'

def will_buy(folder,symbol,win_percent,lost_percent,win_counter,lost_counter)

   statistic_file=File.expand_path("./win_lost_statistic/#{folder}/#{symbol}.txt","#{AppSettings.resource_path}")
   will_buy_path=File.expand_path("./will_buy/#{folder}/#{symbol}.txt","#{AppSettings.resource_path}")

   will_buy_file=File.new(will_buy_path,"w+")
  if File.exists?(statistic_file)
     contents=File.read(statistic_file).split("\n")
     contents.each do |line|
     win_lost=JSON.parse(line.split("#")[1])
     will_buy_file<<line  if win_lost[3].to_f >win_percent && win_lost[1].to_f>win_counter
     will_buy_file<<line  if (1-win_lost[3].to_f) >lost_percent && win_lost[2].to_f>lost_counter
     end
  end
  will_buy_file.close
  File.delete(will_buy_file) if File.stat(will_buy_file).size==0
end

def generate_all_will_buy(folder,win_percent,lost_percent,win_counter,lost_counter)
   will_folder_path=File.expand_path("./will_buy/#{folder}","#{AppSettings.resource_path}")   
   Dir.mkdir(will_folder_path) unless File.exists?(will_folder_path)
   count=0
   $all_stock_list.keys.each do |symbol|
   	count+=1
   	puts "#{symbol},#{count}"
   	will_buy(folder,symbol,win_percent,lost_percent,win_counter,lost_counter)
   end
end

if $0==__FILE__

  folder="percent_3_num_9_days"
  will_folder_path=File.expand_path("./will_buy/#{folder}","#{AppSettings.resource_path}")   
   Dir.mkdir(will_folder_path) unless File.exists?(will_folder_path)

  #will_buy(folder,"000009.sz",90,90,10,10)

  generate_all_will_buy(folder,90,90,10,10)
end