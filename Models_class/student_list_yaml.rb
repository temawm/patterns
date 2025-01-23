require 'yaml'
require 'C:/Users/temaf/NotepadFiles/OOP_in_Ruby/student_short'
require 'C:/Users/temaf/NotepadFiles/OOP_in_Ruby/student'
require_relative 'data_list'


class StudentsListYAML
  def initialize(file_path)
    @file_path = file_path
    @students = read_from_file
  end

  # Чтение всех значений из файла
  def read_from_file
    if File.exist?(@file_path)
      YAML.load_file(@file_path).map { |student_data| Student.new(**student_data) }
    else
      []
    end
  end

  # Запись всех значений в файл
  def write_to_file
    File.write(@file_path, @students.map(&:to_h).to_yaml)
  end

  # Получить объект класса Student по ID
  def get_student_by_id(id)
    @students.find { |student| student.id == id } || (raise "Student with ID #{id} not found")
  end

  # Получить список k по счету n объектов класса Student_short
  def get_k_n_student_short_list(k, n, existing_data_list = nil)
    start_index = (k - 1) * n
    selected_students = @students[start_index, n] || []
    
    student_shorts = selected_students.map { |student| StudentShort.from_student(student) }
    
    if existing_data_list
      existing_data_list.set_elements(student_shorts)
      existing_data_list
    else
      DataList.new(student_shorts)
    end
  end

  # Сортировать элементы по набору Фамилия Инициалы
  def sort_by_name
    @students.sort_by!(&:initials)
  end

  # Добавить объект класса Student в список
  def add_student(student)
    student.id = next_id
    @students << student
    write_to_file
  end

  # Заменить элемент списка по ID
  def replace_student_by_id(id, new_student)
    index = @students.find_index { |student| student.id == id }
    raise "Student with ID #{id} not found" unless index

    new_student.id = id
    @students[index] = new_student
    write_to_file
  end

  # Удалить элемент списка по ID
  def delete_student_by_id(id)
    @students.reject! { |student| student.id == id } || (raise "Student with ID #{id} not found")
    write_to_file
  end

  # Получить количество элементов
  def get_student_short_count
    @students.size
  end

  private

  # Генерация нового ID
  def next_id
    max_id = @students.map(&:id).compact.max || 0
    max_id + 1
  end
end
