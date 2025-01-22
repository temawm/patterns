class DataTable
  def initialize(data)
    raise ArgumentError, "Данные должны быть двумерным массивом" unless data.is_a?(Array) && data.all? { |row| row.is_a?(Array) }
    @data = data
  end
end
