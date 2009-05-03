#!/usr/bin/ruby
require 'range'

colo = Hash.new{nil}

while not $stdin.eof? do 
  h = $stdin.readline.strip
  p = h.split(/\./).reverse
  coloname = p[2..-3].join(".")
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
  else
    colo[coloname][p.last] = Range.new([]) if colo[coloname][p.last].nil?
  end
  
end

def show_hosts(hosts,colo)
  hosts.keys.sort.each do |k|
  #  puts "  #{k}#{hosts[k].summary}"
    puts "#{k}#{hosts[k].to_s}.grp.#{colo}"
  end
end

colo.keys.sort.each do |c| 
  show_hosts(colo[c],c) 
  puts ""
end



