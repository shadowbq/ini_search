module IniSearch
  class CLI

    def self.invoke
      self.new
    end

    def initialize  
      @options = {}
      @options[:verbose] = 0
      @options[:key] = 'key'
      @options[:sect_regexp] = Regexp.new('.*')
      @options[:find_existance] = false

      optparse = OptionParser.new do |opts|
        opts.banner = "Search ini configs"
        opts.separator "Usage: #$0 [options]"

        opts.on( '-s', '--section [section regex string]', "default: #{@options[:sect_regexp].source}", 'Section name as a regular expression to match') do |section|
          @options[:sect_regexp] =  Regexp.new(section)
        end

        opts.on( '-k', '--key [searchkey]', "default: #{@options[:key]}", 'Stanza key') do |key|
          @options[:key] = key
        end

        opts.on( '-x', '--check-for-existance ', "default: #{@options[:find_existance]}", 'Report existance of key in Stanza') do
          @options[:find_existance] = true
        end

        opts.on( '-f', '--file [configfilename]', 'Individual ini file') do |conf|
          @options[:file] = conf
        end

        opts.on('-v', '--verbose', 'Verbose output') do
          @options[:verbose] = 1
        end

        opts.on('-z', '--max-verbose', 'Max Verbose output') do
          @options[:verbose] = 2
        end

        opts.on_tail( '-h', '--help', 'Display this screen' ) do
          puts opts
          exit
        end

      end  
    
      #Verify the options
      begin
        raise unless ARGV.size > 0
        optparse.parse!
        exclusive_options = [:verbose, :scandir]

        if (exclusive_options.collect{|item| item if @options.include? item}.compact).length > 1 
          puts "Error: Mutually Exclusive options were selected"    
          puts optparse
          exit
        end
       
      #If options fail display help
      rescue
        puts optparse
        exit
      end

      begin
        Searcher.new(obj_inifile: IniFile.new(:filename => @options[:file]), key: @options[:key],  sect_regexp: @options[:sect_regexp], find_existance: @options[:find_existance], verbosity: @options[:verbose])
      rescue
        $stderr.puts "Could not read #{@options[:file]}"
        exit 1
      end

    end
  
  end
end    