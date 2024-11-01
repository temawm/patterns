class Student < Person
  private_class_method :new
  
  def self.from_person(person)
    new(
      id: person.id,
      last_name: person.last_name,
      first_name: person.first_name,
      middle_name: person.middle_name,
      phone: person.phone,
      telegram: person.telegram,
      email: person.email,
      github: person.github
    )
  end

  def self.from_string(id:, contact_info:)
    student = new(id: id, last_name: '', first_name: '', middle_name: '')
    student.parse_contact_info(contact_info)  # Этот вызов теперь будет работать
    student
  end

  def initialize(id:, last_name:, first_name:, middle_name:, phone: nil, telegram: nil, email: nil, github: nil)
    super(id: id, last_name: last_name, first_name: first_name, middle_name: middle_name, phone: phone, telegram: telegram, email: email, github: github)
  end

  def get_info
    contacts_info = generate_contact_info
    "#{last_name} #{first_name} #{middle_name}. (#{contacts_info})"
  end

  # Сделайте parse_contact_info публичным
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

  def generate_contact_info
    contacts = []
    contacts << "GitHub: #{github}" if github
    contacts << "Телефон: #{phone}" if phone
    contacts << "Telegram: #{telegram}" if telegram
    contacts.join(', ')
  end
end
