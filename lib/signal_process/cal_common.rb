def cal_per(a,b)
	return ((a.to_f/(a+b))*100).round(2)
end

def calculate_percent(true_false_array)

	true_count=0
	false_count=0

	true_false_array.each do |array|
		if array=="true"
		  true_count+=1 
		 else
		 	false_count+=1
		 end
	end

#	print [true_count,false_count,cal_per(true_count,false_count)].to_s+"\n"
[true_count,false_count,cal_per(true_count,false_count)]
end