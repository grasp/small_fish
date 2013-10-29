def get_all_possible_zuhe

count=0
zuhe=(1..100).to_a

size=zuhe.size

1.upto(zuhe.size).each do |i|
	j=size-i
	j.downto(0).each do |k|
     #puts zuhe[k,i]
     count+=1
end
end
puts "count=#{count}"

end

def get_all_possible_zuhe2(ori_array)


   iter_array=[0,1]
   possible_zuhe=[]
   total_size=ori_array.size

iter_array.each do |cycle|
 iter_array[cycle].upto(total_size-1).each do |i|
 	first_index=i
 	(i+1).upto(total_size-1).each do |j|
 		possible_zuhe<<[i,j]
 	end
 end

end

puts possible_zuhe.size
possible_zuhe
end

if $0==__FILE__
  get_all_possible_zuhe2((1..100).to_a)
end