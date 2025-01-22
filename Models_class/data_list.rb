require_relative 'data_table'

class DataList
  def initialize(elements)
    @elements = elements
    @selected = []
  end
  
  def set_elements(new_elements)
    @elements = new_elements
  end
  
  def generate_table_data
    names = get_names
    table_data = get_data(names)
    DataTable.new(table_data)
  end

  def select(number)
    raise ArgumentError, "Некорректный номер" unless number.is_a?(Integer) && number.between?(0, @elements.size - 1)

    @selected << number unless @selected.include?(number)
  end
  def get_selected
    @selected.map { |index| @elements[index] }
  end

  def get_names
    raise NotImplementedError, "Метод должен быть реализован в наследниках"
  end

  def get_data
    raise NotImplementedError, "Метод должен быть реализован в наследниках"
  end
end
