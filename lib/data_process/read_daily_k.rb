
#将日线数据转化成hash
#hash的key 为日期数据
#hash 的值为几个基本数据，依次为开盘，最高，最低，收盘，成交量
def read_daily_k_file(symbol)

  price_hash=Hash.new

 #stock_file_path=File.join(h_data_path,symbol+".txt")
  stock_file_path=File.expand_path("../../../resources/history_daily_data/#{symbol}.txt",__FILE__)
  puts stock_file_path
  raise unless File.exist?(stock_file_path)

  #快速载入到内存
  daily_k=File.read(stock_file_path)

  price_line_array=daily_k.split("\n")

  price_line_array.each do |line|	   
 	daily_data = line.split(",")

 	#成交量为0的我们忽略不计，因为yahoo会把一些没有交易的数值计算在内，不知道会导致后面数据不匹配吗？
 	#如果数据没有基于price_hash产生，就会有问题，索引的下标会不一样！！！
 	
 	next if (daily_data[2].nil? ||daily_data[6].to_f==0)
 	price_hash[daily_data[1]]=[daily_data[2],daily_data[3],daily_data[4],daily_data[5],daily_data[6],daily_data[7].strip]
 end

price_hash
end

if $0==__FILE__
	puts read_daily_k_file("000009.sz")
end
