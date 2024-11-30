def custom_find_all
    result = []
    @array.each do |el|
      result << el if yield(el)
    end
    result
  end