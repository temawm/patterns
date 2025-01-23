require 'yaml'
require 'json'

# Абстрактный суперкласс для списка студентов
class StudentsList
  def initialize(file_path)
    @file_path = file_path
    @students = []
  end

  def read_all
    raise NotImplementedError, 'Метод должен быть реализован в подклассах'
  end

  def write_all
    raise NotImplementedError, 'Метод должен быть реализован в подклассах'
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

# Класс для работы с JSON
class StudentsListJSON < StudentsList
  def read_all
    file_content = File.read(@file_path)
    parsed_data = JSON.parse(file_content, symbolize_names: true)
    @students = parsed_data.map do |student_hash|
      Student.new(**student_hash)
    end
  end

  def write_all
    data = @students.map do |student|
      {
        id: student.id,
        last_name: student.last_name,
        first_name: student.first_name,
        middle_name: student.middle_name,
        phone: student.phone,
        telegram: student.telegram,
        email: student.email,
        github: student.github
      }
    end
    File.write(@file_path, JSON.pretty_generate(data))
  end
end

# Класс для работы с YAML
class StudentsListYAML < StudentsList
  def read_all
    file_content = File.read(@file_path)
    parsed_data = YAML.safe_load(file_content, symbolize_names: true)
    @students = parsed_data.map do |student_hash|
      Student.new(**student_hash)
    end
  end

  def write_all
    data = @students.map do |student|
      {
        id: student.id,
        last_name: student.last_name,
        first_name: student.first_name,
        middle_name: student.middle_name,
        phone: student.phone,
        telegram: student.telegram,
        email: student.email,
        github: student.github
      }
    end
    File.write(@file_path, YAML.dump(data))
  end
end
