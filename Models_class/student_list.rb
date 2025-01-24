require 'C:/Users/temaf/NotepadFiles/OOP_in_Ruby/student_short'
require 'C:/Users/temaf/NotepadFiles/OOP_in_Ruby/student'

# Путь к JSON-файлу для чтения
input_file_path = "C:/Users/temaf/NotepadFiles/Models_class/student.json"

# Путь для записи результата
output_file_path = "C:/Users/temaf/NotepadFiles/Models_class/student_output.json"


class StudentsList
  attr_accessor :strategy

  def initialize(strategy)
    @strategy = strategy
    @students = []
  end

  def load_from_file(file_path)
    @students = @strategy.read(file_path)
  end

  def save_to_file(file_path)
    @strategy.write(file_path, @students)
  end

  def get_student_by_id(id)
    @students.find { |student| student.id == id }
  end

  def add_student(student)
    new_id = (@students.map(&:id).max || 0) + 1
    student.id = new_id
    @students << student
  end

  def replace_student_by_id(id, new_student)
    index = @students.find_index { |student| student.id == id }
    raise ArgumentError, "Студент с ID #{id} не найден" unless index

    new_student.id = id
    @students[index] = new_student
  end

  def delete_student_by_id(id)
    @students.reject! { |student| student.id == id }
  end

  def get_k_n_student_short_list(k, n, data_list = nil)
    start_index = (k - 1) * n
    student_slice = @students[start_index, n]
    short_list = student_slice.map do |student|
      StudentShort.from_student(student)
    end

    data_list ||= DataList.new([])
    data_list.set_elements(short_list)
    data_list
  end

  def get_student_short_count
    @students.size
  end
end

# Интерфейс стратегии
class StudentsListStrategy
  def read(file_path)
    raise NotImplementedError, 'Метод должен быть реализован в подклассах'
  end

  def write(file_path, students)
    raise NotImplementedError, 'Метод должен быть реализован в подклассах'
  end
end

require 'json'

class StudentsListJSON < StudentsListStrategy
  def read(file_path)
    JSON.parse(File.read(file_path)).map { |student_data| Student.new(**student_data.transform_keys(&:to_sym)) }
  end

  def write(file_path, students)
    formatted_json = JSON.pretty_generate(students.map(&:to_h))
    File.open(file_path, 'w') do |file|
      file.write(formatted_json)
    end
  end
end

require 'yaml'

class StudentsListYAML < StudentsListStrategy
  def read(file_path)
    YAML.load_file(file_path).map { |student_data| Student.new(**student_data.transform_keys(&:to_sym)) }
  end

  def write(file_path, students)
    formatted_yaml = students.map(&:to_h).to_yaml(line_width: -1)
    File.open(file_path, 'w') do |file|
      file.write(formatted_yaml)
    end
  end
end



students_list = StudentsList.new(StudentsListJSON.new)
students_list.load_from_file(input_file_path)

students_list.save_to_file(output_file_path)

puts "Студенты успешно записаны в файл: #{output_file_path}"