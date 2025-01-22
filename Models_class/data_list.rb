require_relative 'data_table'

class DataList
  def initialize(elements)
    @elements = elements.sort
    @selected = []
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
