#!/usr/bin/ruby
begin
  require 'net/http'
  require 'ruby-progressbar'
  require 'progress_bar'
  require 'progress_bar/core_ext/enumerable_with_progress'

rescue => e
  puts e
end

def main()
  url   = 'http://<domain>' # add ip address of victin
  w     = File.open("common.txt") # add wordlist file
  list  = [] 
  
  begin

    for x in w.readlines
      if x === "Documents and Settings\n" or x === "Program Files\n"or x === "reports list\n"
        next
      else
        list.append(x.sub("\n", ""))
      end
    end
  
  rescue => e
    puts e
  end

  begin
    
    for x in list
      (list.find_index(x)...list.length()).to_a.with_progress.select{|i| (i % 2).zero? }

      domain  = "%s/%s" % [url, x.to_s()]
      uri     = URI.parse(domain)
      resp    = Net::HTTP.get_response(uri)
       
      if resp.code === "200" || resp.code === "301"
        puts resp.code + " " + domain
      end
    end

  rescue => e
   puts e 
  end
end

def progress()
  (1...4000).with_progress.select{ |i| (i % 2).zero?}
end

main()

