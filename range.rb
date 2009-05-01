class Range
  def initialize(arg)
    @d = []
    @start = nil
    @last = nil
    @next = nil
    arg.sort.each {|x| add(x)}
  end
  def add(i)
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
    else
      "#{@start}-#{@last}"    
    end
  end  
  def to_s
    if @start == @last and @d.length == 0
      @start.to_s
    else
      @d << range_part_str
      @d.join(",")
    end
  end
end
