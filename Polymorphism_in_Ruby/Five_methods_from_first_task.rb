def read_array_from_file(file_path)
  File.open(file_path, 'r') { |file| file.readline.split.map(&:to_i) }
end

def get_input_array
  puts "Введите массив чисел через пробел: "
  gets.chomp.split.map(&:to_i)
end

# Задача 1: Найти количество элементов, расположенных после последнего максимального
def count_after_last_max(array)
  max_index = array.each_with_index.max_by { |x, idx| x }.last
  array.drop(max_index + 1).size
end

# Задача 2: Разместить элементы до минимального в конце массива
def move_before_min_to_end(array)
  min_index = array.each_with_index.min_by { |x, idx| x }.last
  array.drop(min_index).concat(array.take(min_index))
end

# Задача 3: Найти максимальный элемент в интервале a..b
def max_in_interval(array, a, b)
  array[a..b].max
end

# Задача 4: Индексы элементов, которые меньше своего левого соседа, и их количество
def indices_and_count_less_than_left(array)
  indices = array.each_with_index.select { |x, idx| idx > 0 && x < array[idx - 1] }.map(&:last)
  { indices: indices, count: indices.size }
end

# Задача 5: Простые делители всех элементов массива без повторений
def unique_prime_divisors(array)
  array.flat_map do |num|
    (2..num).select do |i|
      num % i == 0 && (2..Math.sqrt(i)).none? { |j| i % j == 0 }
    end
  end.uniq
end

# Меню выбора задачи
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

# Основная программа
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
    puts "Результат: #{count_after_last_max(array)}"
  when 2
    puts "Результат: #{move_before_min_to_end(array)}"
  when 3
    puts "Введите интервал (a b): "
    a, b = gets.split.map(&:to_i)
    puts "Результат: #{max_in_interval(array, a, b)}"
  when 4
    result = indices_and_count_less_than_left(array)
    puts "Индексы: #{result[:indices]}, Количество: #{result[:count]}"
  when 5
    puts "Результат: #{unique_prime_divisors(array)}"
  else
    puts "Неверный выбор задачи"
  end
end

main


