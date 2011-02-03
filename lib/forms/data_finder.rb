# -*- encoding : utf-8 -*-
class Forms::DataFinder
  
  include Singleton
  
  def initialize
    @base_path = Forms::Config.instance.data_directory
    @data = {}
    preload_files
  end
  
  def find_data(path_s)
    path = path_s.to_s.split(".")
    target = @data
    path.each do |partial_path|
      if target
        target = target[partial_path]
      else
        raise "Can't locate data at #{path_s}"
      end
    end
    target
  end
  
  protected
  
  # Loads all files in base directory.
  def preload_files
    yml_files = Dir.new(@base_path).entries.find_all { |file| file =~ /\.yml$/}
    yml_files.each do |file|
      load_file(file.sub(".yml", ""))
    end
  end
  
  def load_file(file_name)
    file_path = "#{@base_path}/#{file_name}.yml"
    document = YAML::load_file(file_path) 
    
    raise "File is empty #{file_path}" unless document
    # raise "Too many root items." if document.size > 1
    @data[file_name.to_s] = document
  end
  
end
