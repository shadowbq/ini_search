module IniSearch
  class Searcher
    include Helper

    def initialize(arg={})
      @inifile = arg[:obj_inifile] || raise MissingIniFile
      @verbosity = arg[:verbosity] || 0
      @key = arg[:key] || raise MissingSearchKey
      @find_existance = arg[:find_existance] || false
      @section_regex = arg[:sect_regexp] || Regexp.new('.*')
      do_search
    end

    private

		#obj_inifile, key, find_existance
    def do_search
      myfile.each_section do |section| 
        if myfile[section].has_key?(@key) && section.match(sect_regexp)
          verbose "Found '#{key}' Exists: " if @find_existance
          puts "#{section}" if @find_existance
          if key_enabled?(section) && !(key_falsy?(section))
          	verbose "Found '#{key}' Enabled: #{myfile[section][@key]} " 
            puts "#{section}" 
          end
        end
      end #enum
    end #def

    def key_enabled?(section)
    	begin 
        if myfile[section][@key].to_s == "1" || myfile[section][@key].downcase == "true" || myfile[section][@key] == true
          return true
        else
          return false
        end
      rescue # Failure is falsy
        return false
      end  
    end

    def key_falsy?(section)
      begin
        if myfile[section][@key].to_s == "0" || myfile[section][@key].downcase == "false" ||  myfile[section][@key] == "" 
          return true
        else
          return false
        end
      rescue # Failure is falsy
        return true
      end   
    end

	end
end