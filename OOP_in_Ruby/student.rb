class Student
  attr_reader :id, :last_name, :first_name, :middle_name, :telegram, :email, :github 

  def initialize(id:, last_name:, first_name:, middle_name:, phone: nil, telegram: nil, email: nil, github: nil)
    @id = id
    @last_name = last_name
    @first_name = first_name
    @middle_name = middle_name
    set_contacts(phone: phone, telegram: telegram, email: email, github: github)
  end
  
  def set_contacts(phone: nil, telegram: nil, email: nil, github: nil)
    self.phone = phone
    self.telegram = telegram
    self.email = email
    self.github = github
  end
  private

  def self.valid_phone_number?(phone)
    phone =~ /^\d{10,15}$/
  end

  def self.valid_telegram?(telegram)
    telegram.start_with?("@")
  end

  def self.valid_github?(github)
    github.start_with?("https://github.com/")
  end

  def self.valid_email?(email)
    email.include?("@")
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

  def telegram=(telegram)
    if telegram.nil? || Student.valid_telegram?(telegram)
      @telegram = telegram
    else
      raise ArgumentError, "Некорректный Telegram"
    end
  end

  def email=(email)
    if email.nil? || Student.valid_email?(email)
      @email = email
    else
      raise ArgumentError, "Некорректная почта"
    end
  end

  def github=(github)
    if github.nil? || Student.valid_github?(github)
      @github = github
    else
      raise ArgumentError, "Некорректная ссылка на GitHub"
    end
  end

  def contact_present?
    !(@phone.nil? && @telegram.nil? && @email.nil?)
  end

  def github_present?
    !@github.nil? && Student.valid_github?(@github)
  end
  def validate
    raise "Нет контакта для связи" unless contact_present?
    raise "Нет ссылки на GitHub" unless github_present?
    true
  end

  def to_s
    "ID: #{@id}, ФИО: #{@last_name} #{@first_name} #{@middle_name}, " +
    "Телефон: #{@phone || 'не указан'}, Telegram: #{@telegram || 'не указан'}, " +
    "Почта: #{@email || 'не указана'}, GitHub: #{@github || 'не указан'}"
  end
end
