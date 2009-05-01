#!/usr/bin/ruby

hosts = []
open(Dir["NODE*"].sort.last,"r") do |fh|
  header = fh.readline  #skip this line
  while not fh.eof? do
    hosts << fh.readline.split(/,/)[1]
  end
end


colo = Hash.new{[]}
hosts.each do |h|
  p = h.split(/\./).reverse
  coloname = p[2]
  /^([^\.]*)\./.match(h)
  colo[coloname] = colo[coloname] + [$1]
end

def normalize_hosts(h)  # show host list reduced
  n = nil
  pre = nil
  n_start = 0
  h.each do |host|
    /^(\d*)(.+)$/.match(host.reverse)
    ah = $2.reverse
    an = $1.reverse.to_i
#    puts "#{host} #{n_start} #{n} #{ah}" 
    if n == nil
      n = an
      n_start = an
      pre = ah
    elsif (an != n + 1) or (ah != pre)
      if n_start == 0
        puts pre
      elsif n_start == n
        puts "#{pre}#{n_start}"
      else    
        puts "#{pre}[#{n_start}-#{n}]"
      end
      n = an 
      n_start = an 
      pre = ah
    else
      n = an
    end
  end
  puts "#{pre}#{n + 1}"
end
 
def show_hosts(hosts)
  hosts.sort! do |a,b| 
    /^(\d*)(.+)$/.match(a.reverse)
    ah = $2.reverse
    an = $1.reverse
    /^(\d*)(.+)$/.match(b.reverse)
    bh = $2.reverse
    bn = $1.reverse
    #   puts "#{a} #{b} #{ah} #{an}  #{bh} #{bn}"
    if ah == bh
      an.to_i <=> bn.to_i
    else
      a <=> b
    end
  end
  
  normalize_hosts(hosts)
end



colo.keys.sort.each do |c| 
  puts "#{c} #{colo[c].length}"
  show_hosts(colo[c]) 
  puts ""
end


