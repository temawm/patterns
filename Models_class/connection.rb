require 'pg'

begin
  connection = PG.connect(
    dbname: 'Students',
    user: 'postgres',
    password: 'password',
    host: 'localhost',
    port: 5432
  )
  puts "Соединение с базой установлено"

  result = connection.exec("SELECT * FROM student;")
  result.each do |row|
    puts "ID: #{row['student_id']}, ФИО: #{row['last_name']} #{row['first_name']} #{row['middle_name']}, 
    Телефон: #{row['phone']}, Email: #{row['email']}, Telegram: #{row['telegram']}, Git: #{row['git']}"
  end

rescue PG::Error => e
  puts "Ошибка подключения или выполнения запроса: #{e.message}"
ensure
  connection.close if connection
end
