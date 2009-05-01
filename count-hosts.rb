#!/usr/bin/ruby
require 'range'

hosts = []
open(Dir["NODE*"].sort.last,"r") do |fh|
  header = fh.readline  #skip this line
  while not fh.eof? do
    hosts << fh.readline.split(/,/)[1]
  end
end

colo = Hash.new{nil}
hosts.each do |h|
  p = h.split(/\./).reverse
  coloname = p[2]
  if colo[coloname].nil?
    colo[coloname] = Hash.new{nil}
  end
  name = p.last.reverse  # this is just silly, but it works
  if /^(\d+)(.*)/.match(name)
    n = $2.reverse
    d = $1.reverse.to_i
    if colo[coloname][n].nil?
      colo[coloname][n] = Range.new([])
    end
    colo[coloname][n].add(d)
  end
end

def show_hosts(hosts)
  hosts.keys.sort.each do |k|
    puts "  #{k}#{hosts[k].to_s}"
  end
end

colo.keys.sort.each do |c| 
  puts "#{c} "
  show_hosts(colo[c]) 
  puts ""
end



