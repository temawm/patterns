def read_array_from_file(file_path)
  File.open(file_path, 'r') { |file| file.readline.split.map(&:to_i) }
end

def get_input_array
  puts "Введите массив чисел через пробел: "
  gets.chomp.split.map(&:to_i)
end

# Задача 1: Найти количество элементов, расположенных после последнего максимального
def elements_after_last_max(array)
  last_max_index = array.rindex(array.max)
  count = array[last_max_index + 1..-1].size
end


# Задача 2: Разместить элементы до минимального в конце массива
def move_before_min_to_end(array)
  min_index = array.index(array.min)
  result = array[min_index..-1] + array[0...min_index]
  result.inspect
end

# Задача 3: Найти максимальный элемент в интервале a..b
def max_in_interval(array, a, b)
  puts "Максимальный элементв интервале: #{array[a..b].max}"
end

# Задача 4: Индексы элементов, которые меньше своего левого соседа, и их количество
def indices_and_count_less_than_left(array)
  def indices_and_count_of_smaller_than_left(array)
	  indices = array.each_with_index.select { |el, idx| idx > 0 && el < array[idx - 1] }.map(&:last)
	  count = indices.size
	  { indices: indices.inspect, count: count }
	end
end

# Задача 5: Простые делители всех элементов массива без повторений
def unique_prime_divisors(array)
  array.flat_map do |num|
    (2..num).select do |i|
      num % i == 0 && (2..Math.sqrt(i)).none? { |j| i % j == 0 }
    end
  end.uniq
end

def task_menu
  puts <<-MENU
    Выберите задачу:
    1. Количество элементов после последнего максимального
    2. Разместить элементы до минимального в конце массива
    3. Найти максимальный элемент в интервале a..b
    4. Индексы элементов, меньших своего левого соседа
    5. Простые делители без повторений
  MENU
  gets.to_i
end

def main
  puts "Выберите источник данных: 1 - файл, 2 - клавиатура"
  source = gets.to_i
  array = case source
          when 1
            puts "Введите путь к файлу: "
            file_path = gets.chomp
            read_array_from_file(file_path)
          when 2
            get_input_array
          else
            puts "Неверный выбор"
            return
          end

  task = task_menu

  case task
  when 1
	puts "Количество элементов после последнего максимального: #{elements_after_last_max(array)}"
  when 2
    puts "Новый массив: #{move_before_min_to_end(array)}"
  when 3
    puts "Введите интервал (a b): "
    a, b = gets.split.map(&:to_i)
    puts "#{max_in_interval(array, a, b)}"
  when 4
    result = indices_and_count_less_than_left(array)
    puts "Индексы элементов: #{result[:indices]}"
	puts "Количество таких элементов: #{result[:count]}"
  when 5
    puts "Результат: #{unique_prime_divisors(array)}"
  else
    puts "Неверный выбор задачи"
  end
end

main


