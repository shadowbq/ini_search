ini_search
==========

This is a native Ruby package for searching INI files to find enabled keys.

Description
-----------

Usage of `ini-search` binary.

	Search ini configs
	Usage: ~/ini-search [options]
	    -s [section regex string],       default: .*
	        --section                    Section name as a regular expression to match
	    -k, --key [searchkey]            default: key
	                                     Stanza key
	    -x, --check-for-existance        default: false
	                                     Report existance of key in Stanza
	    -f, --file [configfilename]      Individual ini file
	    -v, --verbose                    Verbose output
	    -z, --max-verbose                Max Verbose output
	    -h, --help                       Display this screen

### Example Use

	$ ini-search -f ~/.rvm/gems/ruby-2.1.2/gems/IniSearch-0.0.1/test/data/good.ini -k one
	section_one:one


### Example File Format Matches

A typical INI file might look like this:

    [section1]
    ; some comment on section1
    var1 = false
    var2 = true
    varA = Foobar
    var3 = multiline values \
    are also possible

    [section2]
    # another comment
    var10 = baz
    var20 = 1	    

We would be looking for section1:var2, section2:var20 as *Enabled* settings


### Identifying Enabled Variables

* 1  -->  Enabled
* ""  -->  Disabled
* "42"  -->  Set
* "1"  -->  Enabled
* "3.14159"  -->  Set
* "true"  -->  Enabled
* true  -->  Enabled
* "false"  -->  Disabled
* "normal string"  -->  Set

Install
-------

    gem install IniSearch

Testing
-------

To run the tests:

    $ rake

License
-------

MIT License
Copyright (c) 2006 - 2014    