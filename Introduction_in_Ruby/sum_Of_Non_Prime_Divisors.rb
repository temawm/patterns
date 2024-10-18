# Проверка на простоту числа
def prime?(n)
  return false if n <= 1
  (2..Math.sqrt(n)).each do |i|
    return false if n % i == 0
  end
  true
end

# Функция для нахождения суммы непростых делителей числа
def sum_of_non_prime_divisors(n)
  divisors = []
  
  # Находим все делители
  (1..n).each do |i|
    divisors << i if n % i == 0
  end
  
  # Для каждого вызываем функцию на проверку простоты
  non_prime_divisors = divisors.reject { |d| prime?(d) }
  
  # Блок return
  non_prime_divisors.sum
end

# Пример использования
print "Введите число: "
number = gets.to_i

sum = sum_of_non_prime_divisors(number)
puts "Сумма непростых делителей числа #{number} = #{sum}"
