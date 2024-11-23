require_relative 'person'

class Student < Person
  attr_reader :last_name, :first_name, :middle_name, :phone, :telegram, :email

  def initialize(id:, github: nil, last_name:, first_name:, middle_name:, phone: nil, telegram: nil, email: nil)
    super(id: id, github: github)
    self.middle_name = middle_name
	self.first_name = first_name
	self.last_name = last_name
    set_contacts(phone: phone, telegram: telegram, email: email)
  end
  
  def set_contacts(phone: nil, telegram: nil, email: nil)
    self.phone = phone
    self.telegram = telegram
    self.email = email
  end

  def get_info
    contacts_info = generate_contact_info
    "#{last_name} #{first_name} #{middle_name}. (#{contacts_info})"
  end

  def initials
    "#{last_name} #{first_name[0]}.#{middle_name[0]}."
  end

  private
  
  def self.valid_name_parts?(string)
    string.match?(/\A[A-ZА-Я][a-zа-яё\-']{0,}\z/)
  end
  
  def middle_name=(middle_name)
    self.class.valid_name_parts?(middle_name) ? @middle_name = middle_name : raise(ArgumentError, middle_name)
  end

  def first_name=(first_name)
    self.class.valid_name_parts?(first_name) ? @first_name = first_name : raise(ArgumentError, first_name)
  end

  def last_name=(last_name)
    self.class.valid_name_parts?(last_name) ? @last_name = last_name : raise(ArgumentError, last_name)
  end

  def phone=(phone)
    if self.class.phone_checker(phone)
      @phone = phone
    else
      raise ArgumentError, "Некорректный номер телефона"
    end
  end

  def telegram=(telegram)
    if self.class.telegram_checker(telegram)
      @telegram = telegram
    else
      raise ArgumentError, "Некорректный Telegram. Он должен начинаться с @"
    end
  end

  def email=(email)
    if self.class.email_checker(email)
      @email = email
    else
      raise ArgumentError, "Некорректный email"
    end
  end

  def self.phone_checker(phone)
    phone.nil? || phone =~ /^\d{10,15}$/
  end

  def self.email_checker(email)
    email.nil? || email.include?('@')
  end

  def self.telegram_checker(telegram)
    telegram.nil? || telegram.start_with?('@')
  end

  def generate_contact_info
    contacts = []
    contacts << "GitHub: #{github}" if github
    contacts << "Телефон: #{phone}" if phone
    contacts << "Telegram: #{telegram}" if telegram
    contacts << "Email: #{email}" if email
    contacts.join(', ')
  end
end
