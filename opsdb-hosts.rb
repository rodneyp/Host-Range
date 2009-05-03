#!/usr/bin/ruby
hosts = []
open(Dir["NODE*"].sort.last,"r") do |fh|
  header = fh.readline  #skip this line
  while not fh.eof? do
    puts fh.readline.split(/,/)[1]
  end
end

