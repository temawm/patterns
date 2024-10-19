class Student
  attr_reader :id, :last_name, :first_name, :middle_name
  attr_accessor :telegram, :email, :github

  def initialize(id:, last_name:, first_name:, middle_name:, phone: nil, telegram: nil, email: nil, github: nil)
    @id = id
    @last_name = last_name
    @first_name = first_name
    @middle_name = middle_name
    self.phone = phone
    @telegram = telegram
    @email = email
    @github = github
  end

  def self.valid_phone_number?(phone)
    phone =~ /^\d{10,15}$/
  end

  def phone
    @phone
  end

  def phone=(phone)
    if phone.nil? || Student.valid_phone_number?(phone)
      @phone = phone
    else
      raise ArgumentError, "Некорректный номер телефона"
    end
  end

  def to_s
    "ID: #{@id}, ФИО: #{@last_name} #{@first_name} #{@middle_name}, " +
    "Телефон: #{@phone || 'не указан'}, Telegram: #{@telegram || 'не указан'}, " +
    "Почта: #{@email || 'не указана'}, GitHub: #{@github || 'не указан'}"
  end
end
