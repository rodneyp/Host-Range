#!/usr/bin/ruby
require 'range'

class HostRange < IntRange
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
  c = p[2..-3].join(".")
  if colo[c].nil?
    colo[c] = Hash.new{nil}
  end
  name = p.last.reverse  # this is just silly, but it works
  if /^(\d+)(.*)/.match(name)
    n = $2.reverse
    d = $1.reverse.to_i
    if colo[c][n].nil?
      colo[c][n] = HostRange.new(n,h)
    end
    colo[c][n] << d
  else
    colo[c][p.last] = HostRange.new(p.last,h) if colo[c][p.last].nil?
  end
end

colo.keys.sort.each do |c| 
  colo[c].keys.sort.each do |k|
    puts colo[c][k].to_s
  end
  puts ""
end



