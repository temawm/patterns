require 'fox16'

include Fox

class StudentApp < FXMainWindow
  def initialize(app)
    super(app, "Student Manager", width: 800, height: 600)

    # Контейнер для содержимого
    main_frame = FXVerticalFrame.new(self, LAYOUT_FILL)

    # Вкладка "Student List"
    FXLabel.new(main_frame, "Список студентов", nil, JUSTIFY_CENTER_X | LAYOUT_FILL_X)

    # Область фильтрации
    filter_frame = FXHorizontalFrame.new(main_frame, LAYOUT_FILL_X | FRAME_THICK | FRAME_RAISED)
    FXLabel.new(filter_frame, "Фильтр: ")
    @filter_text = FXTextField.new(filter_frame, 20, opts: TEXTFIELD_NORMAL)

    # Таблица студентов
    @student_table = FXTable.new(main_frame, opts: TABLE_READONLY | LAYOUT_FILL | FRAME_THICK | FRAME_RAISED)
    @student_table.setTableSize(0, 2) # Количество строк и столбцов
    @student_table.setColumnText(0, "Имя")
    @student_table.setColumnText(1, "Возраст")
    @student_table.connect(SEL_COMMAND) do
      update_buttons
    end

    # Кнопки: Добавить, Изменить, Удалить, Обновить
    button_frame = FXHorizontalFrame.new(main_frame, LAYOUT_FILL_X | FRAME_THICK | FRAME_RAISED)
    
    # Кнопка добавить
    @add_button = FXButton.new(button_frame, "Добавить", nil, nil, 0, LAYOUT_SIDE_LEFT | FRAME_THICK)
    @add_button.connect(SEL_COMMAND) { add_student }

    # Кнопка изменить
    @edit_button = FXButton.new(button_frame, "Изменить", nil, nil, 0, LAYOUT_SIDE_LEFT | FRAME_THICK)
    @edit_button.connect(SEL_COMMAND) { edit_student }
    @edit_button.enabled = false

    # Кнопка удалить
    @delete_button = FXButton.new(button_frame, "Удалить", nil, nil, 0, LAYOUT_SIDE_LEFT | FRAME_THICK)
    @delete_button.connect(SEL_COMMAND) { delete_student }
    @delete_button.enabled = false

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
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  # Метод для добавления студента
  def add_student
    name = "Student #{rand(1000)}" # Генерация случайного имени
    age = rand(18..25) # Генерация случайного возраста

    # Добавляем данные в таблицу
    row = @student_table.getNumRows
    @student_table.setTableSize(row + 1, 2) # Увеличиваем количество строк

    @student_table.setItemText(row, 0, name)
    @student_table.setItemText(row, 1, age.to_s)
    update_buttons
  end

  # Метод для редактирования студента
  def edit_student
    selected_row = @student_table.getSelectedRows.first
    return unless selected_row

    name = "Updated Student"
    age = rand(18..25)

    @student_table.setItemText(selected_row, 0, name)
    @student_table.setItemText(selected_row, 1, age.to_s)
  end

  # Метод для удаления студента
  def delete_student
    selected_rows = @student_table.getSelectedRows
    return if selected_rows.empty?

    selected_rows.each do |row|
      @student_table.setTableSize(@student_table.getNumRows - 1, 2)
      @student_table.deleteRows(row, 1)
    end
    update_buttons
  end

  # Метод для обновления списка студентов с фильтром
  def update_students
    filter = @filter_text.text.strip.downcase
    (0...@student_table.getNumRows).each do |row|
      name = @student_table.getItemText(row, 0).downcase
      age = @student_table.getItemText(row, 1)

      if filter.empty? || name.include?(filter) || age.include?(filter)
        @student_table.showRow(row)
      else
        @student_table.hideRow(row)
      end
    end
  end

  # Метод для сброса фильтра
  def reset_filter
    @filter_text.text = ""
    update_students
  end

  # Метод для обновления состояния кнопок
  def update_buttons
    selected_rows = @student_table.getSelectedRows
    if selected_rows.empty?
      @edit_button.enabled = false
      @delete_button.enabled = false
    elsif selected_rows.length == 1
      @edit_button.enabled = true
      @delete_button.enabled = true
    else
      @edit_button.enabled = false
      @delete_button.enabled = true
    end
  end
end

if __FILE__ == $0
  app = FXApp.new
  StudentApp.new(app)
  app.create
  app.run
end
