class Range
  def initialize(arg)
    @d = []
    @start = nil
    @last = nil
    @next = nil
    @elements = []
    arg.sort.each {|x| add(x)}
  end
  def add(i)
    @elements << i
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
    @elements.sort.each {|x| calc(x)}
    if @start == @last and @d.length == 0
      @start.to_s
    else
      @d << range_part_str
      "[#{@d.join(",")}]"
    end
  end
end
