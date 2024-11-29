
def elements_after_last_max(array)
  last_max_index = array.rindex(array.max)
  count = array[last_max_index + 1..-1].size
  puts "Количество элементов после последнего максимального: #{count}"
end

def move_before_min_to_end(array)
  min_index = array.index(array.min)
  result = array[min_index..-1] + array[0...min_index]
  puts "Новый массив: #{result.inspect}"
end

def max_in_interval(array, a, b)
  max_element = array[a..b].max
  puts "Максимальный элемент в интервале #{a}..#{b}: #{max_element}"
end

def indices_and_count_of_smaller_than_left(array)
  indices = array.each_with_index.select { |el, idx| idx > 0 && el < array[idx - 1] }.map(&:last)
  count = indices.size
  puts "Индексы элементов: #{indices.inspect}"
  puts "Количество таких элементов: #{count}"
end

def unique_prime_divisors(array)
  array.flat_map do |num|
    (2..num).select do |i|
      num % i == 0 && (2..Math.sqrt(i)).none? { |j| i % j == 0 }
    end
  end.uniq
  puts "Простые делители: #{primes}"
  primes
end


