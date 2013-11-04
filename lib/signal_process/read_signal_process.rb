


def read_signal_process(symbol)

	 signal_array=[]

	 signal_file=File.expand_path("../../../resources/signal_gen/#{symbol}.txt",__FILE__)

     #load file into memory
     signal_file_text=File.read(signal_file)

     #分行
     signal_file_array=signal_file_text.split("\n")

     #获取索引
     signal_keys=signal_file_array[0].gsub(/\[|\]|\"/,"").split(",")

     1.upto(signal_file_array.size-2).each do |back_day|
      signal_array << signal_file_array[back_day].gsub(/\d|\-|\s|\[|\]|\"/,"").split(",")
     end
    # puts signal_keys
   [signal_keys, signal_array]
end

def get_signal_zhang_in_one_day

end


if $0==__FILE__
	a= read_signal_process("000009.sz")
end