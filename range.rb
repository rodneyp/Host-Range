class Range
  def initialize(arg)
    @d = []
    @start = nil
    @last = nil
    arg.sort.each {|x| add(x)}
  end
  def add(i)
    @start = i
  end
  def to_s
    @start.to_s
  end
end
