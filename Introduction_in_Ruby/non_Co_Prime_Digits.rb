require 'mathn' 

def find_special_numbers(number)
  # Найти все делители числа
  divs = divisors(number)
  # Найти сумму простых цифр
  sum_prime_digits = sum_of_prime_digits(number)
  # Найти все числа, не являющиеся делителями
  non_divisors = (1..number).reject { |i| divs.include?(i) }
  # Найти числа, не являющиеся взаимно простыми с исходным числом
  non_coprime = non_divisors.reject { |i| gcd(i, number) == 1 }
  # Найти числа, которые взаимно просты с суммой простых цифр
  result = non_coprime.select { |i| gcd(i, sum_prime_digits) == 1 }
end

# Функция для проверки, является ли число простым
def prime?(n)
  return false if n <= 1
  (2..Math.sqrt(n)).none? { |i| n % i == 0 }
end

# Функция для нахождения НОД двух чисел
def gcd(a, b)
  a.gcd(b)
end

# Функция для нахождения делителей числа
def divisors(n)
  result = []
  (1..Math.sqrt(n)).each do |i|
    if n % i == 0
      result << i
      result << n / i unless i == n / i
    end
  end
  result
end

# Функция для нахождения суммы простых цифр
def sum_of_prime_digits(n)
  sum = 0
  n.to_s.each_char do |char|
    digit = char.to_i
    sum += digit if prime?(digit)
  end
  sum
end

# Пример выполнения
print "Введите число: "
number = gets.to_i

result = find_special_numbers(number)
puts "Количество таких чисел: #{result.length}"
