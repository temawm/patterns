require 'C:/Users/temaf/NotepadFiles/OOP_in_Ruby/student_short'  # Абсолютный путь
require_relative 'data_list'

class DataListStudentShort < DataList
  def get_names
    ["initials", "github", "contact"]
  end

  def get_data
    table_data = @elements.map.with_index do |student, index|
      [index + 1] + student.values_at(*get_names)
    end
    DataTable.new(table_data)
  end
end
