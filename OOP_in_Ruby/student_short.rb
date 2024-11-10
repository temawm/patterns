class StudentShort < Person
  private_class_method :new

  def self.from_student(student)
    new(
	  id: student.id,
	  surname_initials: student.initials,
	  contact: student.contact,
	  github: student.github
	)

  end

  def self.from_contact_info(id, contact_info)
    match = contact_info.match(/(.+), GitHub: (.+)?, Телефон: (.+)?, Telegram: (.+)?, Email: (.+)?/)
    raise ArgumentError, "Некорректный формат строки contact_info" unless match

    name_parts = match[1].split(' ')
    surname_initials = name_parts[1] + name_parts[2][0] + name_parts[3][0]

    new(
      id: id,
      surname_initials: surname_initials,
	  github: match[2],
      contact: match[5] || match[3] || match[4]
    )
  end

  def initialize(surname_initials, id: nil, git: nil, contact: nil)
	@surname_initials = surname_initials
	@contact = contact
    super(id: id, git: git)
  end

  def get_info
    contacts = []
    contacts << "GitHub: #{@github}" if @github
    contacts << "Контакт: #{@contact}" if @contact
    contacts_info = contacts.join(', ')

    initials = "#{@surname_initials} (#{contacts_info})"
  end

  private

end
