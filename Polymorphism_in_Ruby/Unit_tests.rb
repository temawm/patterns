require 'minitest/autorun'
require_relative 'Array_methods'

class TestArrayProcessor < Minitest::Test
  def setup
    @processor = ArrayProcessor.new([1, 2, 3, 4, 5, 6])
  end

  def test_custom_find_all
    assert_equal([2, 4, 6], @processor.custom_find_all { |x| x.even? })
    assert_equal([1, 3, 5], @processor.custom_find_all(&:odd?))
    assert_equal([], @processor.custom_find_all { |x| x > 10 })
  end

  def test_custom_min_max
    assert_equal([1, 6], @processor.custom_min_max)
    assert_equal([6, 1], @processor.custom_min_max { |a, b| b <=> a })
    assert_nil(ArrayProcessor.new([]).custom_min_max)
  end

  def test_custom_reduce
    assert_equal(21, @processor.custom_reduce(0) { |sum, el| sum + el })
    assert_equal(720, @processor.custom_reduce(1) { |prod, el| prod * el })
    assert_equal(-21, @processor.custom_reduce(0) { |diff, el| diff - el })
  end

  def test_custom_none?
    assert(@processor.custom_none? { |x| x > 10 })
    refute(@processor.custom_none? { |x| x < 4 })
  end

  def test_custom_find_index
    assert_equal(3, @processor.custom_find_index { |x| x > 3 })
    assert_equal(1, @processor.custom_find_index(&:even?))
    assert_nil(@processor.custom_find_index { |x| x > 10 })
  end

  def test_custom_any?
    assert(@processor.custom_any? { |x| x > 5 })
    refute(@processor.custom_any? { |x| x > 10 })
  end
end
