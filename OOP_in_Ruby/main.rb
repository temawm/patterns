require_relative 'person' 
require_relative 'student'    
require_relative 'student_short' 

person = Person.new(
  id: 1,
  last_name: "Усков",
  first_name: "Артём",
  middle_name: "Алексеевич",
  phone: "1234567890",
  telegram: "@tema",
  email: "tema@example.com",
  github: "https://github.com/tema"
)

puts "Person:"
puts "ID: #{person.id}, Name: #{person.last_name} #{person.first_name} #{person.middle_name}, Phone: #{person.phone}, Telegram: #{person.telegram}, Email: #{person.email}, GitHub: #{person.github}"


student_from_person = Student.from_person(person)
puts "\nStudent from Person:"
puts student_from_person.get_info


contact_info_string = "Усков Артём Алексеевич, GitHub: https://github.com/tema, Телефон: 1234567890, Telegram: @tema"
student_from_string = Student.from_string(id: 2, contact_info: contact_info_string)
puts "\nStudent from Contact Info String:"
puts student_from_string.get_info


student_short_from_person = StudentShort.from_person(person)
puts "\nStudentShort from Person:"
puts student_short_from_person.get_info


student_short_from_student = StudentShort.from_student(student_from_person)
puts "\nStudentShort from Student:"
puts student_short_from_student.get_info


student_short_from_string = StudentShort.from_contact_info(3, contact_info_string)
puts "\nStudentShort from Contact Info String:"
puts student_short_from_string.get_info
