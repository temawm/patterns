class DataTable
  def initialize(data)
    raise ArgumentError, "Данные должны быть двумерным массивом" unless data.is_a?(Array) && data.all? { |row| row.is_a?(Array) }
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
end
