#!/usr/bin/ruby -w

require_relative "HandGroupValidator.rb"

cards = []
if ARGV.length == 0
    puts "No arguments found"
    puts "Usage: ./main.rb \"cards|{A, 1, 2, 3, 4 .. J, Q, K}|{h, d, s, c, j}\""
    puts "\nExample: ./main.rb \"4h, 4c, 4s, 4d\"" 
    puts "Example: ./main.rb \"Qh, Kh, 1j\"" 
    exit
else
    # parse args
    s = ARGV[0].gsub(/\s+/, "")
    cards = s.split(",")
    puts "checking cards=#{cards}"
end

begin
    if handValidateCardGroup(cards)
        puts "#{cards} are valid Hand group :)"
    else
        puts "#{cards} are Invalid Hand group! :("
    end
rescue => e
    puts "Invalid cards! error:"
    puts "#{e.class}: #{e.message}"
    puts e.backtrace.join("\n")
end
