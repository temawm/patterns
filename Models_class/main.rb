require_relative 'data_list_student_short'

# Создаем объекты StudentShort с корректными ссылками на GitHub
student1 = StudentShort.new(
  id: 1,
  initials: "A. Ivanov",
  github: "https://github.com/ivanov",
  contact: "ivanov@mail.com"
)

student2 = StudentShort.new(
  id: 2,
  initials: "B. Petrov",
  github: "https://github.com/petrov/",
  contact: "petrov@mail.com"
)

student3 = StudentShort.new(
  id: 3,
  initials: "C. Sidorov",
  github: "https://github.com/sidorov-repo",
  contact: "sidorov@mail.com"
)


# Создаем список студентов
students = [student1, student2, student3]

# Создаем экземпляр DataListStudentShort
data_list = DataListStudentShort.new(students)

# Вызываем метод generate_table_data и выводим данные
table = data_list.generate_table_data
puts "Сгенерированная таблица:"
table.to_a.each { |row| puts row.inspect }
