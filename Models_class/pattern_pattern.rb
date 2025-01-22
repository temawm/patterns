class Drink
  # Шаблонный метод
  def prepare
    boil_water
    brew
    pour_in_cup
    add_condiments
  end

  # Шаблонный метод вызывает общий метод, но переопределяемые шаги
  def boil_water
    puts "Кипятим воду"
  end

  def pour_in_cup
    puts "Наливаем в чашку"
  end

  # Эти методы будут переопределены в подклассах
  def brew
    raise "Не реализовано в базовом классе"
  end

  def add_condiments
    raise "Не реализовано в базовом классе"
  end
end

class Tea < Drink
  def brew
    puts "Завариваем чай"
  end

  def add_condiments
    puts "Добавляем лимон"
  end
end

class Coffee < Drink
  def brew
    puts "Завариваем кофе"
  end

  def add_condiments
    puts "Добавляем сахар и молоко"
  end
end

tea = Tea.new
tea.prepare

coffee = Coffee.new
coffee.prepare
