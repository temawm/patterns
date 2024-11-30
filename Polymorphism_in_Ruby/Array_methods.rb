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