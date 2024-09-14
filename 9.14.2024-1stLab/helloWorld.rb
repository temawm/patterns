# Выводим в консоль "Привет, мир!" 
puts("Hello World!")

# Проверяем, передан ли аргумент программе
if ARGV.length == 0
	puts("Укажите ваше имя")
	# Завершаем программу, если аргумент не был передан
	exit
end

# Получаем имя пользователя как аргумент программы
user_name = ARGV[0]
puts("Здравствуйте, #{user_name}!")

print("\n")

# Спрашиваем у пользователя любимый язык программирования
print("\nКакой ваш любимый язык программирования?")
favorite_language = STDIN.gets.chomp.downcase 

# Проверка на Ruby
if favorite_language == "ruby"
	puts "#{user_name}, ты подлиза!"

else
	puts "Скоро будет Ruby, #{user_name}!"
	
	# Обрабатываем разные ответы
	case favorite_language
	when "python"
		puts "Ruby лучше чем Python"
	when "java"
		puts "Ruby лучше чем Java"
	when "javascript"
    	puts "Ruby лучше чем JavaScript"
	else
		# Иначе
		puts "Я не знаю, что сказать о #{favorite_language}..."		
	end
end

print("---------------------")

# Просим пользователя ввести команду на языке Ruby
print "\n Введите команду на языке Ruby: "
print "Например: puts 'Hello World', 8 - 4, Time.now: "
ruby_command = STDIN.gets.chomp

# Выполняем команду Ruby 
puts "Результат выполнения команды Ruby:"
begin
  eval(ruby_command)  # Блок try
rescue StandardError => e
  puts "Ошибка в команде Ruby: #{e.message}"  # Блок catch
end

print("---------------------")

print "\nВведите команду операционной системы: "
os_command = STDIN.gets.chomp

puts "Результат выполнения команды OC:"
system(os_command)