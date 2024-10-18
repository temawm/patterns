# Функция для нахождения количества цифр, меньших 3
def count_digits_less_than_3(number)
  # Преобразуем число в строку и затем в массив его цифр
  digits = number.to_s.chars
  
  # Преобразуем каждый символ в целое число и находим кол-во меньших 3
  count = digits.count { |digit| digit.to_i < 3 }
  
  count
end

# Пример использования
print "Введите число: "
number = gets.to_i

result = count_digits_less_than_3(number)
puts "Количество цифр, меньших 3: #{result}"
