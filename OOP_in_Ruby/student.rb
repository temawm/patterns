require_relative 'person'

class Student < Person
  attr_reader :last_name, :first_name, :middle_name, :phone, :telegram, :email, :id , :github
  attr_writer :last_name, :firs_name, :middle_name, :github
		
  def initialize(last_name:, first_name:, middle_name:, phone: nil, telegram: nil, email: nil, id: nil, github: nil)
    super(id: id, github: github)
    self.middle_name = middle_name
	self.first_name = first_name
	self.last_name = last_name
    set_contacts(phone: phone, telegram: telegram, email: email)
  end
  
  def to_h
    {
      id: @id,
      last_name: @last_name,
      first_name: @first_name,
      middle_name: @middle_name,
      phone: @phone,
      telegram: @telegram,
      email: @email,
      github: @github
    }
  end  
  
  def set_contacts(phone: nil, telegram: nil, email: nil)
    self.phone = phone
    self.telegram = telegram
    self.email = email
  end
  
  def get_info()
	contacts_info = generate_contact_info
    "#{last_name} #{first_name} #{middle_name}. (#{contacts_info})"
  end 

  def initials
    "#{last_name} #{first_name[0]}.#{middle_name[0]}."
  end
  
  def self.valid_name_parts?(string)
    string.match?(/\A[\w\s\-']+\z/)
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
    return "Телефон: #{phone}" if phone
    return "Telegram: #{telegram}" if telegram
    return "Email: #{email}" if email
  end
  
  def contact()
	return phone if phone
	return telegram if telegram
	return email if email
  end
  
  def values_at(attributes)
    attributes.map do |attr|
      case attr.to_s
	  when 'id' then @id
	  when 'first_name' then @first_name
	  when 'middle_name' then @middle_name
	  when 'last_name' then @last_name
      when 'phone' then @phone
	  when 'email' then @email
	  when 'telegram' then @telegram
      when 'github' then @github
      else nil
      end
    end
  end
  
  private

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
  
  def github=(github)
    if Person.github_checker(github)
      @github = github
    else
      raise ArgumentError, "Некорректный git"
    end
  end

end



