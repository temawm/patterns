class StudentShort < Person
  attr_reader :contact_info

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

  def self.from_student(student)
    new(
      id: student.id,
      last_name: student.last_name,
      first_name: student.first_name,
      middle_name: student.middle_name,
      phone: student.phone,
      telegram: student.telegram,
      email: student.email,
      github: student.github
    )
  end

  def self.from_contact_info(id, contact_info)
    match = contact_info.match(/(.+), GitHub: (.+)?, Телефон: (.+)?, Telegram: (.+)?/)
    raise ArgumentError, "Некорректный формат строки contact_info" unless match

    name_parts = match[1].split(' ')
    last_name = name_parts[0]
    first_name = name_parts[1] || ""  # Пустая строка, если имя отсутствует
    middle_name = name_parts[2] || ""  # Пустая строка, если отчество отсутствует

    new(
      id: id,
      last_name: last_name,
      first_name: first_name,
      middle_name: middle_name,
      phone: match[3],
      telegram: match[4],
      github: match[2]
    )
  end

  def initialize(id:, last_name:, first_name: "", middle_name: "", phone: nil, telegram: nil, email: nil, github: nil)
    super(id: id, last_name: last_name, first_name: first_name, middle_name: middle_name, phone: phone, telegram: telegram, email: email, github: github)
    @contact_info = get_info
  end

  def get_info
    contacts = []
    contacts << "GitHub: #{@github}" if @github
    contacts << "Телефон: #{@phone}" if @phone
    contacts << "Telegram: #{@telegram}" if @telegram
    contacts_info = contacts.join(', ')

    initials = "#{@first_name[0]}.#{@middle_name[0]}." unless @first_name.empty? || @middle_name.empty?
    "#{@last_name} #{initials} (#{contacts_info})"
  end

  private

end
