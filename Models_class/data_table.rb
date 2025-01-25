class DataTable
  def initialize(data)
    @data = data
  end

  def get_element(row, col)
    @data[row][col]
  end
  
  def columns_count
    @data.to_a.empty? ? 0 : @data.first.size
  end

  def rows_count
    @data.to_a.size
  end
  
  def to_a
    @data
  end
  
  def each(&block)
    @data.to_a.each(&block)
  end
 
end
