class Person
  attr_reader :id, :last_name, :first_name, :middle_name, :phone, :telegram, :email, :github

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

  def phone=(phone)
    if phone.nil? || phone =~ /^\d{10,15}$/
      @phone = phone
    else
      raise ArgumentError, "Некорректный номер телефона"
    end
  end

  def telegram=(telegram)
    if telegram.nil? || telegram.start_with?('@')
      @telegram = telegram
    else
      raise ArgumentError, "Некорректный Telegram. Он должен начинаться с @"
    end
  end

  def email=(email)
    if email.nil? || email.include?('@')
      @email = email
    else
      raise ArgumentError, "Некорректный email"
    end
  end

  def github=(github)
    if github.nil? || github.start_with?('https://github.com/')
      @github = github
    else
      raise ArgumentError, "Некорректный GitHub URL"
    end
  end
end
