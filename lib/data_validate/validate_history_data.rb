def validate_history_daily_data(date)

	data_folder=File.expand_path("../../../resources/history_daily_data",__FILE__)
	invalid_history_file=File.expand_path("../../../resources/data_validate/invalid_history_daily_data.txt",__FILE__)
	invalid_file=File.new(invalid_history_file,"w+")
    count=0
	Dir.new(data_folder).each do |file|
		next if (file=="." || file=="..")
		file_path= File.expand_path("../../../resources/history_daily_data/#{file}",__FILE__)
		temp_file=File.new(file_path)
		#puts file.readlines[1]
		last_line=temp_file.readlines[-2..-1].to_s
		#puts last_line if file.to_s.match("000002.sz")
		 unless last_line.match(date)
          invalid_file<< file.to_s+"\n" 
          count+=1
         end
		temp_file.close
		#file=File.new(file_path)

		#puts file.seek(-50, IO::SEEK_END)
        #file.close
	end

	puts "total invalid history daily data file = #{count}"
  invalid_file.close
end

if $0==__FILE__    
	puts validate_history_daily_data("2013-11-01")
end