
require File.expand_path("../../../init/small_fish_init.rb",__FILE__)
require 'json'

def statistic_for_win_lost(folder,percent,count)

	statistic_folder=File.expand_path("./win_lost_statistic/#{folder}","#{AppSettings.resource_path}")
    count=0

    buy_object_folder=File.expand_path("./buy_object/#{folder}","#{AppSettings.resource_path}")
    Dir.mkdir(buy_object_folder) unless File.exists?(buy_object_folder)

    buy_object_file=File.expand_path("./buy_object/#{folder}/percent_#{(percent*100).to_i}_count_#{count}.txt","#{AppSettings.resource_path}")
    target_file=File.new(buy_object_file,"w+")
	Dir.new(statistic_folder).each do |file|
	  unless file=="." || file==".."
	  	statistic_file=File.expand_path("./win_lost_statistic/#{folder}/#{file}","#{AppSettings.resource_path}")
	  	contents_array=File.read(statistic_file).split("\n")
	  	contents_array.each do |line|
	  		result=line.split("#")
	  		array=JSON.parse(result[1])
	  	    if array[1].to_f >count &&array[3].to_f >percent
	  	    	count+=1
	  	    	target_file<<file+"#"+array[1].to_s+"#"+array[3].to_s+"\n"	  	    	
	  	    	puts "#{file},#{count}"
	  	    	break #TBD,will only allown one
	  	    end
	  	end
	  end
	end
	 target_file.close
end

if $0==__FILE__
	start=Time.now
    folder="percent_1_num_1_days"
	statistic_for_win_lost(folder,0.9,10)
	puts "cost=#{Time.now-start}"
end