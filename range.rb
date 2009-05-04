class IntRange < Array
  @@min_reduce = 2
  def initialize(arg)
    super
    @d = []
    @start = nil
    @last = ""
    @next = nil
    self.replace(arg)
  end
  def calc(i)
    if i != @next
      @d << range_part_str unless @start.nil?
      @start = i
    end
    @last = i
    @next = i + 1
  end
  def range_part_str
    if @last - @start < @@min_reduce
      Range.new(@start,@last).to_a.join(",")
    else
      "#{@start}-#{@last}"    
    end
  end  
  def to_s
    self.sort.each {|x| calc(x)}
    if self.length < 2
      @last.to_s
    else
      @d << range_part_str 
      "[#{@d.join(",")}]"
    end
  end
end

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
  def reduce; to_s; end
  def expand
    self.sort.collect  do |n|
      "#{@name}#{n}.#{@host}"
    end
  end
end

