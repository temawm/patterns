def find_minimum_with_for(array)
  return nil if array.empty?
  min_value = array[0]
  for i in 1...array.length
    if array[i] < min_value
      min_value = array[i]
    end
  end
  min_value
end

def find_maximum_with_for(array)
  return nil if array.empty?
  max_value = array[0]
  for i in 1...array.length
    if array[i] > max_value
      max_value = array[i]
    end
  end
  max_value
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

def read_array_from_file(file_path)
  File.open(file_path, 'r') do |file|
    file.readline.split.map { |i| i.to_i } 
  end
rescue Errno::ENOENT
  puts "Ошибка: файл не найден."
  exit
end

def execute_method(method_name, file_path)
  array = read_array_from_file(file_path)
  case method_name
  when 'find_minimum'
    puts "Минимальный элемент: #{find_minimum_with_for(array)}"
  when 'find_maximum'
    puts "Максимальный элемент: #{find_maximum_with_for(array)}"
  when 'find_first_positive'
    puts "Номер первого положительного элемента (сделано через while): #{find_first_positive_index_with_while(array)}"
  else
    puts "Ошибка: нераспознанный метод."
  end
end

if ARGV.length != 2
  puts "Использование: ruby program.rb <метод> <путь_к_файлу>"
  exit
end

method_name = ARGV[0]
file_path = "ruby findMinAndFirstNumberMoreThan0WithFileReadingAndConsoleArguments.rb "C:\Users\temaf\NotepadFiles\9.14.2024-1stLab\example.txt" find_minimum"

execute_method(method_name, file_path)
