

def find_maximum_with_for(array)
  return nil if array.empty?
  min_value = max_value
  for i in 1...array.length
    if array[i] < min_value
      min_value = array[i]
    end
  end
  return min_value
end


def find_maximum_with_for(array)
  return false if array.empty? 
  max_value = array[0]
  for i in 1...array.length
	if array[i] > max_value
	  max_value = array[i]
	end
  end
  return max_value
end


def find_first_positive_index_with_while(array)
  i = 0
  while i < array.length
    if array[i] > 0
      return i
    end
    i += 1
  end
  nil
end

array = [3, -2, 5, 0, -1, 7]

puts "Минимальный элемент): #{find_minimum_with_for(array)}"
puts "Максимальный элемент): #(find_maximum_with_for(array)}"
puts "Номер первого положительного элемента (сделано через while): #{find_first_positive_index_with_while(array)}"

