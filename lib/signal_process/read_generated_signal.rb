

if false
def read_signal_process(symbol)

	 signal_array=[]

	 signal_file=File.expand_path("../../../resources/signal_gen/#{symbol}.txt",__FILE__)

     #load file into memory
     signal_file_text=File.read(signal_file)

     #分行
     signal_file_array=signal_file_text.split("\n")

     #获取索引
     signal_keys=signal_file_array[0].gsub(/\[|\]|\"/,"").split(",")

     1.upto(signal_file_array.size-1).each do |back_day|
      signal_array << signal_file_array[back_day].gsub(/\d|\-|\s|\[|\]|\"/,"").split(",")
     end
    # puts signal_keys
   [signal_keys, signal_array]
end
end

def read_signal_gen(symbol)

     signal_hash=Hash.new

     signal_file=File.expand_path("../../../resources/signal_gen/#{symbol}.txt",__FILE__)

     #load file into memory
     signal_file_text=File.read(signal_file)

     #分行
     signal_file_array=signal_file_text.split("\n")

     #获取索引
     signal_keys=signal_file_array[0].gsub(/\[|\]|\"/,"").split(",")

     1.upto(signal_file_array.size-1).each do |back_day|
     # signal_array << signal_file_array[back_day].gsub(/\d|\-|\s|\[|\]|\"/,"").split(",")
     result=signal_file_array[back_day].split("[")
      key=result[0]
      next if result[1].nil?  #TBD
      value=result[1].gsub(/\]|\"/,"").split(",")
      signal_hash[key]=value
     end
    # puts signal_keys
   [signal_keys, signal_hash]
end

def get_signal_zhang_in_one_day

end


if $0==__FILE__
	a= read_signal_gen("000009.sz")
    print a[0]
    print a[1]["2013-10-31"]
end