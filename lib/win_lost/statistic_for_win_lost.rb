require File.expand_path("../../../init/small_fish_init.rb",__FILE__)
def generate_win_lost_counter()
	win_lost=File.expand_path("./win_lost","#{AppSettings.resource_path}")
	Dir.new(win_lost).each do |folder|
      puts folder
	end
end


def generate_counter_for_percent(symbol)
    folder="percent_3_num_3_days"
    signal_file=File.expand_path("./signal/#{symbol}.txt","#{AppSettings.resouce_path}")
    win_lost_file=File.expand_path("./win_lost/#{folder}/#{symbol}.txt","#{AppSettings.resouce_path}")


    win_lost_file=File.read(win_lost_file)

end



if $0==__FILE__
 
 generate_win_lost_counter()
end