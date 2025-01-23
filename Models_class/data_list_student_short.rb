require 'C:/Users/temaf/NotepadFiles/OOP_in_Ruby/student_short'
require_relative 'data_list'

class DataListStudentShort < DataList
  def get_names
    ["initials", "github", "contact"]
  end

  def generate_data(names)
    table_data = @elements.map.with_index do |student, index|
      row = [index + 1] + student.values_at(names)
      puts "Generated row: #{row.inspect}"
      row
    end
    DataTable.new(table_data)
  end

end
