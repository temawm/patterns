require 'C:/Users/temaf/NotepadFiles/OOP_in_Ruby/student_short'  # Абсолютный путь
require_relative 'data_list'

class DataListStudentShort < DataList
  def get_names
    ["initials", "github", "contact"]
  end

  def get_data(names)
    table_data = @elements.map.with_index do |student, index|
      row = [index + 1] + student.values_at(*names)
      puts "Generated row: #{row.inspect}"  # Для отладки
      row
    end
    DataTable.new(table_data)
  end

end
