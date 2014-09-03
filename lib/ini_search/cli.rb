module IniSearch
  class CLI

    def self.invoke
      self.new
    end

    def initialize  
      @options = {}
      @options[:verbose] = 0
      @options[:key] = 'key'

      optparse = OptionParser.new do |opts|
        opts.banner = "Search ini configs"
        opts.separator "Usage: #$0 [options]"

        opts.on( '-k', '--key [searchkey]', @options[:key], 'Stanza Key') do |key|
          @options[:key] = key
        end

        opts.on( '-x', '--check-for-existance ', @options[:find_existance], 'Check for Existance of key in stanza') do
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
    
      #Verrify the options
      begin
        raise unless ARGV.size > 0
        optparse.parse!
        exclusive_options = [:file, :scandir]

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
        search(IniFile.new(@options[:file]), @options[:key], @options[:find_existance])
      rescue
        $stderr.puts "Could not read #{@options[:file]}"
        exit 1
      end

    end

    def search(myfile, key, find_existance)

      myfile.each_section do |section| 
        if myfile[section].has_key?(key) 
          verbose "Found '#{key}' Exists: " if find_existance
          puts "#{section}" if find_existance
          if myfile[section][key] == "1" || myfile[section][key] == "true"
            verbose "Found '#{key}' Enabled: " 
            puts "#{section}" 
          end
        end
      end

    end

    private

    def verbose(msg)
      print "(" + @options[:file] + ")" if @options[:verbose] > 1 
      print msg if @options[:verbose] > 0 
    end  
  
  end
end    