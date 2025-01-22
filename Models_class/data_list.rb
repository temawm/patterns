class DataList
  def initialize(elements)
    @elements = elements.sort
  end

  def get_elements
    @elements.dup
  end
end
