require_relative 'C:/Users/temaf/NotepadFiles/OOP_in_Ruby/person'
require_relative 'C:/Users/temaf/NotepadFiles/OOP_in_Ruby/student'
require_relative 'C:/Users/temaf/NotepadFiles/OOP_in_Ruby/student_short'
require_relative 'C:/Users/temaf/NotepadFiles/Models_class/student_list'
require 'C:/Users/temaf/NotepadFiles/Models_class/data_list_student_short'
require 'json'
require 'yaml'

class StudentListController
  attr_reader :students_list
  attr_accessor :max_page

  def initialize(view)
    @view = view
    @view.controller = self
    @students_list = StudentsList.new(StudentsListJSON.new)
	@student_list = nil
	@page = 1
	@current_page = 1
	@max_page = 1
    load_initial_data
  end
  
  def current_page
    @current_page
  end
  
  def page 
    @page
  end
  
  def pageup
    if @page + 14 <= @max_page * 14 
		@current_page += 1
		@page += 14
		update_view
		update_page_info
	end
  end
  
  def pagedown
	if @page >= 14
		@current_page -= 1
		@page -= 14
		update_view
		update_page_info
	end
  end

  def update_page_info
    @view.update_page_info_label
  end
  
  def load_initial_data
    update_view
  end

  def update_view
    @students_list.load_from_file("C:/Users/temaf/NotepadFiles/Models_class/student.json")
    @student_list = @students_list.get_k_n_student_short_list(@page, @page+31, @student_list)
    @view.display_students(@student_list)
  end

  def add_student(last_name, first_name, middle_name, phone = nil, telegram = nil, email = nil, github = nil)
  end

  def delete_student(id)
  end

  def update_student(id, last_name, first_name, middle_name, phone = nil, telegram = nil, email = nil, github = nil)
  end

  def filter_students(filter)
  end
end
