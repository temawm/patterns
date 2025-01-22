class DataTable
  def initialize(data)
    @data = data
  end

  def get_element(row, col)
    @data[row][col]
  end

  def columns_count
    @data.empty? ? 0 : @data.first.size
  end

  def rows_count
    @data.size
  end
  
  def to_a
    @data
  end
  
  def each(&block)
    @data.each(&block)
  end
 
end
