
require 'range'
require 'test/unit'

class RangeTest < Test::Unit::TestCase
  def test_range
    [["", []],
     ["1", [1]],
     ["1,2", [1,2]],
     ["4-6", [6,4,5]],
     ["1-3", [1,2,3]],
     ["1-4", [1,2,3,4]],
     ["1-3,5", [1,2,3,5]],
     ["1-3,5-7", [1,2,3,5,6,7]],
     ["1,3-5", [1,3,4,5]],
     ["1,3,5,7,9", [1,3,5,7,9]],
     ["1,3,5-7,9", [1,3,5,6,7,9]]].each do |s,a|
       r = Range.new(a)
       assert_equal s, r.to_s
    end
  end
end
