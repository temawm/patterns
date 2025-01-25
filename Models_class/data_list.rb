require_relative 'data_table'

class DataList
  def initialize(elements = nil)
    @elements = elements
    @selected = []
  end
  
  def set_elements(new_elements)
    @elements = new_elements
  end
  
  def get_data
    @elements
  end

  def select(number)
    raise ArgumentError, "Некорректный номер" unless number.is_a?(Integer) && number.between?(0, @elements.size - 1)

    @selected << number unless @selected.include?(number)
  end
  def get_selected
    @selected.map { |index| @elements[index] }
  end

  def get_names
  end

  def generate_data(names)
  end
end
