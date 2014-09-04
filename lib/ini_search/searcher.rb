module IniSearch
  class Searcher
    include Helper

    def initialize(arg={})
      @inifile = arg[:obj_inifile] || (raise MissingIniFile)
      @verbosity = arg[:verbosity] || 0
      @key = arg[:key] || (raise MissingSearchKey)
      @find_existance = arg[:find_existance] || false
      @section_regex = arg[:sect_regexp] || Regexp.new('.*')
      do_search
    end

    private

		#obj_inifile, key, find_existance
    def do_search
      @inifile.each_section do |section| 
        if @inifile[section].has_key?(@key) && section.match(@section_regex)
          verbose("Found '#{section}:#{@key}' Exists: ", @verbosity) if @find_existance
          puts "#{section}" if @find_existance
          if key_enabled?(section) && !(key_falsy?(section))
          	verbose("Found '#{section}:#{@key}' Enabled: #{@inifile[section][@key]} ", @verbosity)
            puts "#{section}:#{@key}" 
          elsif key_falsy?(section)
            verbose("Found '#{section}:#{@key}' Disabled: #{@inifile[section][@key]} ", @verbosity)
          else 
            verbose("Found '#{section}:#{@key}' Set: #{@inifile[section][@key]} ", @verbosity)
          end
        end
      end #enum
    end #def

    def key_enabled?(section)
    	begin 
        if @inifile[section][@key].to_s == "1" || @inifile[section][@key].to_s.downcase == "true" || @inifile[section][@key] == true
          return true
        else
          return false
        end
      rescue 
        raise FailureIniDataSet
      end  
    end

    def key_falsy?(section)
      begin
        if @inifile[section][@key].to_s == "0" ||  @inifile[section][@key] == "" || @inifile[section][@key].to_s.downcase == "false"
          return true
        else        
          return false
        end
      rescue 
        raise FailureIniDataSet
      end   
    end

	end
end