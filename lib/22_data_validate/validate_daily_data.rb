require File.expand_path("../../../init/small_fish_init.rb",__FILE__)

def validate_daily_date(date)
  source_file=File.expand_path("./daily_data/#{date}.txt","#{AppSettings.resource_path}")
  contents=File.read(source_file).split("\n")

  count=0
  contents.each do |line|
  	count+=1 if line.match(/#0\.0/)
  end

  puts contents.size

  return true if (contents.size==2471) && (count < 300)
  return false
end

if $0==__FILE__
	puts validate_daily_date("2013-11-11")
end