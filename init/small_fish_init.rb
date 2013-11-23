require File.expand_path("../config_load.rb",__FILE__)
require File.expand_path("../stock_list_init.rb",__FILE__)
require "logger"
#load  all stock list
table_file=File.expand_path("./#{AppSettings.stock_list_name}","#{AppSettings.resource_path}")
$all_stock_list=load_stock_list_file(table_file)

$logger=Logger.new("#{AppSettings.log_path}",'daily')
$logger.level=Logger::INFO

#mkdir

data_validate_path=File.expand_path("./daily_data","#{AppSettings.resource_path}")
Dir.mkdir(data_validate_path) unless File.exists?(data_validate_path)

data_validate_path=File.expand_path("./data_validate","#{AppSettings.resource_path}")
Dir.mkdir(data_validate_path) unless File.exists?(data_validate_path)

data_process_path=File.expand_path("./data_process","#{AppSettings.resource_path}")
Dir.mkdir(data_process_path) unless File.exists?(data_process_path)

data_process_path=File.expand_path("./signal_process","#{AppSettings.resource_path}")
Dir.mkdir(data_process_path) unless File.exists?(data_process_path)

data_process_path=File.expand_path("./signal_process/two","#{AppSettings.resource_path}")
Dir.mkdir(data_process_path) unless File.exists?(data_process_path)

data_process_path=File.expand_path("./signal_process/two/up_p10_after_3_day","#{AppSettings.resource_path}")
Dir.mkdir(data_process_path) unless File.exists?(data_process_path)

data_process_path=File.expand_path("./signal","#{AppSettings.resource_path}")
Dir.mkdir(data_process_path) unless File.exists?(data_process_path)

