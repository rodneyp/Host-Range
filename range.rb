class IntRange < Array
  def initialize(arg)
    super
    @d = []
    @start = nil
    @last = nil
    @next = nil
    self.replace(arg)
  end
  def calc(i)
    if @start.nil?
      @start = i 
    elsif i != @next
      @d << range_part_str
      @start = i
    end
    @last = i
    @next = i + 1
  end
  def range_part_str
    if @start == @last
      @start.to_i
    elsif @last - @start == 1
      [@start,@last].join(",")
    else
      "#{@start}-#{@last}"    
    end
  end  
  def to_s
    self.sort.each {|x| calc(x)}
    if @start == @last and @d.length == 0
      @start.to_s
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
end

