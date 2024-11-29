require_relative 'person'
require_relative 'student'
require_relative 'student_short'

puts "=== Person ==="
person = Person.new(
  id: 1,
  github: "https://github.com/tema"
)
puts "ID: #{person.id}, GitHub: #{person.github}"

puts "\n=== Student ==="
student = Student.new(
  id: 2,
  last_name: "Усков",
  first_name: "Артём",
  middle_name: "Алексеевич",
  phone: "1234567890",
  telegram: "@tema",
  email: "tema@example.com",
  github: "https://github.com/tema"
)
puts student.get_info

puts "\n=== StudentShort (from Student) ==="
student_short_from_student = StudentShort.from_student(student)
puts student_short_from_student.get_info

puts "\n=== StudentShort (from Contact Info String) ==="
contact_info_string = "Усков Артём, GitHub: https://github.com/tema, Телефон: 1234567890, Telegram: @tema"
student_short_from_string = StudentShort.from_contact_info(3, contact_info_string)
puts student_short_from_string.get_info
