require 'json'
require 'C:/Users/temaf/NotepadFiles/OOP_in_Ruby/student'
require 'C:/Users/temaf/NotepadFiles/OOP_in_Ruby/student_short'
require_relative 'data_list'

class Students_list_JSON
  def initialize(file_path)
    @file_path = file_path
    @students = read_from_file
  end

  # a. Чтение всех значений из файла
  def read_from_file
    if File.exist?(@file_path)
      JSON.parse(File.read(@file_path), symbolize_names: true).map do |student_data|
        Student.new(**student_data)
      end
    else
      []
    end
  end

  # b. Запись всех значений в файл
  def write_to_file
    serialized_data = @students.map do |student|
      {
        id: student.id,
        first_name: student.first_name,
        last_name: student.last_name,
        middle_name: student.middle_name,
        phone: student.phone,
        telegram: student.telegram,
        email: student.email,
        github: student.github
      }
    end
    File.write(@file_path, JSON.pretty_generate(serialized_data))
  end

  # c. Получить объект класса Student по ID
  def get_student_by_id(id)
    @students.find { |student| student.id == id }
  end

  # d. Получить список k по счету n объектов класса Student_short
  def get_k_n_student_short_list(k, n, data_list = nil)
    start_index = (k - 1) * n
    end_index = start_index + n - 1

    selected_students = @students[start_index..end_index]&.map do |student|
      Student_short.from_student(student)
    end

    if data_list
      data_list.set_elements(selected_students)
      data_list
    else
      DataList.new(selected_students)
    end
  end

  # e. Сортировать элементы по набору ФамилияИнициалы
  def sort_by_initials
    @students.sort_by! { |student| student.initials }
  end

  # f. Добавить объект класса Student в список
  def add_student(student)
    max_id = @students.map(&:id).compact.max || 0
    student.id = max_id + 1
    @students << student
    write_to_file
  end

  # g. Заменить элемент списка по ID
  def replace_student_by_id(id, new_student)
    index = @students.find_index { |student| student.id == id }
    if index
      new_student.id = id
      @students[index] = new_student
      write_to_file
    else
      raise "Студент с ID #{id} не найден"
    end
  end

  # h. Удалить элемент списка по ID
  def delete_student_by_id(id)
    @students.reject! { |student| student.id == id }
    write_to_file
  end

  # i. Получить количество элементов
  def get_student_short_count
    @students.size
  end
end
