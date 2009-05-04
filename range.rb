class Range
  def initialize(arg)
    @d = []
    @start = nil
    @last = nil
    @next = nil
    @elements = []
    arg.sort.each {|x| add(x)}
  end
  def add(x); @elements << x; end
  def calc(i)
    if i != @next
      @d << range_part_str unless @next.nil?
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
    @elements.sort.each {|x| calc(x)}
    if @start == @last and @d.length == 0
      @start.to_s
    else
      @d << range_part_str
      "[#{@d.join(",")}]"
    end
  end
end
