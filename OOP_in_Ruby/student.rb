class Student < Person
  private_class_method :new

  def initialize(id:, last_name:, first_name:, middle_name:, phone: nil, telegram: nil, email: nil, github: nil)
    super(id: id, last_name: last_name, first_name: first_name, middle_name: middle_name, phone: phone, telegram: telegram, email: email, github: github)
  end

  def get_info
    contacts_info = generate_contact_info
    "#{last_name} #{first_name} #{middle_name}. (#{contacts_info})"
  end

  def parse_contact_info(contact_info)
    match = contact_info.match(/(.+), GitHub: (.+), Телефон: (.+), Telegram: (.+)/)
    if match
      @last_name = match[1]
      @github = match[2]
      @phone = match[3]
      @telegram = match[4]
      @first_name = ""
      @middle_name = ""
    else
      raise ArgumentError, "Некорректный формат строки contact_info"
    end
  end

  private

  def initials
		"#{middle_name} #{first_name[0]}.#{last_name[0]}."
  end


  def generate_contact_info
    contacts = []
    contacts << "GitHub: #{github}" if github
    contacts << "Телефон: #{phone}" if phone
    contacts << "Telegram: #{telegram}" if telegram
    contacts.join(', ')
  end
end

def contact
    	return phone_number if phone_number
    	return email if email
    	return telegram if telegram
	end