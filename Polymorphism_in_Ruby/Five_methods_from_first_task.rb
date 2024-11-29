def elements_after_last_max(array)
  last_max_index = array.rindex(array.max)
  count = array[last_max_index + 1..-1].size
  puts "Количество элементов после последнего максимального: #{count}"
end
