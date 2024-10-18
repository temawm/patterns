require_relative 'student'

student1 = Student.new(id: 1, last_name: "Иванов", first_name: "Иван", middle_name: "Иванович", phone: "123456789", telegram: "@ivanov", email: "ivanov@example.com", github: "github.com/ivanov")
student2 = Student.new(id: 2, last_name: "Петров", first_name: "Петр", middle_name: "Петрович")
student3 = Student.new(id: 3, last_name: "Сидоров", first_name: "Сидор", middle_name: "Сидорович", phone: "987654321", github: "github.com/sidorov")

puts student1
puts student2
puts student3
