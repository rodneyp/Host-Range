#!/usr/bin/ruby
require 'range'

class HostRange < Range
  def initialize(name,host)
    super([])
    parts = host.split(/\./)
    @name = name
    @host = parts[1..-1].join(".")
  end
  def to_s
    "#{@name}#{super}.#{@host}"
  end
end

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
      colo[coloname][n] = HostRange.new(n,h)
    end
    colo[coloname][n].add(d)
  else
    colo[coloname][p.last] = HostRange.new(p.last,h) if colo[coloname][p.last].nil?
  end
end

def show_hosts(hosts,colo)
  hosts.keys.sort.each do |k|
  #  puts "  #{k}#{hosts[k].summary}"
    puts hosts[k].to_s
  end
end

colo.keys.sort.each do |c| 
  show_hosts(colo[c],c) 
  puts ""
end



