class Student
  attr_reader :id, :last_name, :first_name, :middle_name
  attr_accessor :phone, :telegram, :email, :github

  def initialize(id:, last_name:, first_name:, middle_name:, phone: nil, telegram: nil, email: nil, github: nil)
    @id = id
    @last_name = last_name
    @first_name = first_name
    @middle_name = middle_name
    @phone = phone
    @telegram = telegram
    @email = email
    @github = github
  end
  def to_s
    "ID: #{@id}, ФИО: #{@last_name} #{@first_name} #{@middle_name}, " +
    "Телефон: #{@phone || 'не указан'}, Telegram: #{@telegram || 'не указан'}, " +
    "Почта: #{@email || 'не указана'}, GitHub: #{@github || 'не указан'}"
  end
end
