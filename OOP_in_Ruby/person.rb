class Person
  attr_reader :id, :last_name, :first_name, :middle_name, :phone, :telegram, :email, :github
  attr_writer :last_name, :first_name, :middle_name
  
  def initialize(id:, last_name:, first_name:, middle_name:, phone: nil, telegram: nil, email: nil, github: nil)
    @id = id
    @last_name = last_name
    @first_name = first_name
    @middle_name = middle_name
	@github = github
    set_contacts(phone: phone, telegram: telegram, email: email)
  end

  def set_contacts(phone: nil, telegram: nil, email: nil, github: nil)
    self.phone = phone
    self.telegram = telegram
    self.email = email
  end
  
  private

  def phone=(phone)
    if self.class.phone_checker(phone)
      @phone = phone
    else
      raise ArgumentError, "Некорректный номер телефона"
    end
  end
  
  private

  def telegram=(telegram)
    if self.class.telegram_checker(telegram)
      @telegram = telegram
    else
      raise ArgumentError, "Некорректный Telegram. Он должен начинаться с @"
    end
  end
  
  private

  def email=(email)
    if self.class.email_checker(email)
      @email = email
    else
      raise ArgumentError, "Некорректный email"
    end
  end
  
  private

  def github=(github)
    if self.class.github_checker(github)
      @github = github
    else
      raise ArgumentError, "Некорректный GitHub URL"
    end
  end
  
  private
  
  def self.phone_checker(phone)
    phone.nil? || phone =~ /^\d{10,15}$/
  end
  
  def self.email_checker(email)
    email.nil? || email.include?('@')
  end
  
  def self.telegram_checker(telegram)
    telegram.nil? || telegram.start_with?('@')
  end
end
