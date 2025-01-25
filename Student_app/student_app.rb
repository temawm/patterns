require 'fox16'
require_relative 'C:/Users/temaf/NotepadFiles/OOP_in_Ruby/person'
require_relative 'C:/Users/temaf/NotepadFiles/OOP_in_Ruby/student'
require_relative 'C:/Users/temaf/NotepadFiles/OOP_in_Ruby/student_short'
require_relative 'C:/Users/temaf/NotepadFiles/Models_class/student_list'
require_relative 'C:/Users/temaf/NotepadFiles/Models_class/data_list'
require_relative 'C:/Users/temaf/NotepadFiles/Student_app/student_list_controller'
require 'C:/Users/temaf/NotepadFiles/Models_class/data_list_student_short'
require 'json'

include Fox

class StudentApp < FXMainWindow
  attr_accessor :controller

  def initialize(app)
    super(app, "Student Manager", width: 1400, height: 720)

    main_frame = FXVerticalFrame.new(self, LAYOUT_FILL)

    FXLabel.new(main_frame, "Список студентов", nil, JUSTIFY_CENTER_X | LAYOUT_FILL_X)

    filter_frame = FXHorizontalFrame.new(main_frame, LAYOUT_FILL_X | FRAME_THICK | FRAME_RAISED)
    FXLabel.new(filter_frame, "Фильтр: ")
    @filter_text = FXTextField.new(filter_frame, 20, opts: TEXTFIELD_NORMAL)
	
    @student_table = FXTable.new(main_frame, opts: TABLE_READONLY | LAYOUT_FILL | FRAME_THICK | FRAME_RAISED)
    @student_table.setTableSize(0, 8)
    
    # Заголовки столбцов
    @student_table.setColumnText(0, "ID")
    @student_table.setColumnText(1, "Фамилия")
    @student_table.setColumnText(2, "Имя")
    @student_table.setColumnText(3, "Отчество")
    @student_table.setColumnText(4, "Телефон")
    @student_table.setColumnText(5, "Телеграм")
    @student_table.setColumnText(6, "Email")
    @student_table.setColumnText(7, "GitHub")
	
    
    @student_table.connect(SEL_COMMAND) do
      update_buttons
    end
	
    @controller = StudentListController.new(self)	

	 # Кнопки для переключения страниц
    page_frame = FXHorizontalFrame.new(main_frame, LAYOUT_FILL_X | FRAME_THICK | FRAME_RAISED)

    # Кнопка предыдущей страницы
    @prev_button = FXButton.new(page_frame, "Предыдущая", nil, nil, 0, LAYOUT_SIDE_LEFT | FRAME_THICK)
    @prev_button.connect(SEL_COMMAND) { controller.pagedown }

    # Кнопка следующей страницы
    @next_button = FXButton.new(page_frame, "Следующая", nil, nil, 0, LAYOUT_SIDE_LEFT | FRAME_THICK)
    @next_button.connect(SEL_COMMAND) { controller.pageup }
	
	 # Метка с количеством страниц
    @page_info_label = FXLabel.new(page_frame, "Страница #{controller.current_page} из #{controller.max_page}", nil, LAYOUT_CENTER_X | LAYOUT_SIDE_LEFT)

		
    # Кнопки: Добавить, Изменить, Удалить, Обновить
    button_frame = FXHorizontalFrame.new(main_frame, LAYOUT_FILL_X | FRAME_THICK | FRAME_RAISED)
    
    # Кнопка добавить
    @add_button = FXButton.new(button_frame, "Добавить", nil, nil, 0, LAYOUT_SIDE_LEFT | FRAME_THICK)
    @add_button.connect(SEL_COMMAND) { add_student }

    # Кнопка удалить
    @delete_button = FXButton.new(button_frame, "Удалить", nil, nil, 0, LAYOUT_SIDE_LEFT | FRAME_THICK)
    @delete_button.connect(SEL_COMMAND) { delete_student }
    
    # Кнопка обновить
    @update_button = FXButton.new(button_frame, "Обновить", nil, nil, 0, LAYOUT_SIDE_LEFT | FRAME_THICK)
    @update_button.connect(SEL_COMMAND) { update_students }
    
    # Кнопка сбросить фильтр
    @reset_button = FXButton.new(button_frame, "Сбросить фильтр", nil, nil, 0, LAYOUT_SIDE_LEFT | FRAME_THICK)
    @reset_button.connect(SEL_COMMAND) { reset_filter }

    # Кнопка закрытия окна
    FXButton.new(main_frame, "Close", nil, nil, 0, LAYOUT_SIDE_BOTTOM | FRAME_THICK | LAYOUT_FILL_X).connect(SEL_COMMAND) do
      app.exit
    end

    # Загружаем данные
    @controller.load_initial_data
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  def display_students(data_list)
    @student_table.clearItems
	data_table = data_list.get_data
	row_count = data_table.size
	controller.max_page = 7
	@student_table.setTableSize(28, 8)
	
	
	@student_table.setColumnWidth(5, 200)
	@student_table.setColumnWidth(6, 200) 
	@student_table.setColumnWidth(7, 200)
	
	
    data_table[(controller.page - 1)..(controller.page + 26)].each.with_index do |student, index|
      @student_table.setItemText(index, 0, student.id.to_s)
      @student_table.setItemText(index, 1, student.last_name)
      @student_table.setItemText(index, 2, student.first_name)
      @student_table.setItemText(index, 3, student.middle_name)
      @student_table.setItemText(index, 4, student.phone)
      @student_table.setItemText(index, 5, student.telegram)
      @student_table.setItemText(index, 6, student.email)
      @student_table.setItemText(index, 7, student.github)
	  
	  @student_table.setItemJustify(index, 0, JUSTIFY_LEFT)
	  @student_table.setItemJustify(index, 1, JUSTIFY_LEFT)
	  @student_table.setItemJustify(index, 2, JUSTIFY_LEFT) 
	  @student_table.setItemJustify(index, 3, JUSTIFY_LEFT)
	  @student_table.setItemJustify(index, 4, JUSTIFY_LEFT) 
	  @student_table.setItemJustify(index, 5, JUSTIFY_LEFT) 
	  @student_table.setItemJustify(index, 6, JUSTIFY_LEFT) 
	  @student_table.setItemJustify(index, 7, JUSTIFY_LEFT)
    end
  end
  
  def update_page_info_label
    @page_info_label.text = "Страница #{controller.current_page} из #{controller.max_page}"
  end
  
  
end

if __FILE__ == $0
  app = FXApp.new
  window = StudentApp.new(app)
  app.create
  window.create
  app.run
end
