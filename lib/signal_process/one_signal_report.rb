
require File.expand_path("../split_signal.rb",__FILE__)

def guess_policy(symbol,will_key)

	result_path=File.expand_path("../../../resources/policy/#{symbol}.txt",__FILE__)
    puts result_path
	policy_report  =File.new(result_path,"w+")

	# puts policy_report

     result=split_signal_by_will_key(symbol,will_key)

	 signal_keys=result[0]
	 win_signal_array=result[1]
	 win_lost_array=result[2]

	 win_signal=[]
	 loss_signal=[]
    
    signal_keys.each_index do |index|
    	#puts  win_signal_array[1][index].to_s+"#{index}"
     new_win_array=[]
     win_signal_array.each do |one_win_array|
      new_win_array<<one_win_array[index]    
    end
     win_signal<<calculate_percent(new_win_array)
    end

    puts "calculate lost"

     signal_keys.each_index do |index|
    	#puts  win_signal_array[1][index].to_s+"#{index}"
     new_win_array=[]
     win_lost_array.each do |one_win_array|
      new_win_array<<one_win_array[index]    
    end
     loss_signal<<calculate_percent(new_win_array)
    end

   signal_keys.each_index do |index|
   	policy_report <<signal_keys[index].to_s+" "
   	policy_report <<win_signal[index].to_s+" "
   	policy_report <<loss_signal[index].to_s+" "
   	policy_report <<"\n"
   end
    policy_report.close
   
end

if $0==__FILE__
    guess_policy("000009.sz","up_1_day")
end