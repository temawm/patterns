class ArrayProcessor
  def initialize(array)
    @array = array.dup.freeze
  end

	def custom_find_all
		result = []
		@array.each do |el|
		  result << el if yield(el)
		end
		result
	  end
	  
	def custom_min_max
		min = @array.first
		max = @array.first
		@array.each do |el|
		  min = el if el < min
		  max = el if el > max
		end
		[min, max]
	  end
	  
	def custom_reduce(initial)
		if initial != nil
		  accumulator = initial
		else
		  accumulator = 0
		end
		@array.each do |el|
		  accumulator = yield(accumulator, el)
		end
		accumulator
	end
	
	def custom_none?
		@array.each do |el|
		  return false if yield(el)
		end
		true
	end
	
	def custom_find_index
		@array.each_with_index do |el, index|
		  return index if yield(el)
		end
		nil
	end
	
	def custom_any?
    @array.each do |el|
      return true if yield(el)
    end
    false
  end
	
end





processor = ArrayProcessor.new([1, 2, 3, 4, 5, 6])

# find_all
puts processor.custom_find_all { |el| el.even? }

# min_max
puts processor.custom_min_max.inspect

# reduce
puts processor.custom_reduce(0) { |sum, el| sum + el }

# none?
puts processor.custom_none? { |el| el < 0 }
puts processor.custom_none? { |el| el > 5 }

# find_index
puts processor.custom_find_index { |el| el > 4 }

# any?
puts processor.custom_any? { |el| el > 4 }
puts processor.custom_any? { |el| el < 0 }     
