require_relative 'person'

class StudentShort < Person
  attr_reader :surname_initials, :contact

  private_class_method :new

  def self.from_student(student)
    new(
      id: student.id,
      github: student.github,
      surname_initials: student.initials,
      contact: student.phone || student.telegram || student.email
    )
  end

  def self.from_contact_info(id, contact_info)
    match = contact_info.match(/(.+?)\s+(.+?), GitHub: (.+?), Телефон: (.+?), Telegram: (@\w+)/)
    raise ArgumentError, "Некорректный формат строки contact_info" unless match

    surname_initials = "#{match[1]} #{match[2][0]}."
    contact = match[4] || match[5]

    new(
      id: id,
      github: match[3],
      surname_initials: surname_initials,
      contact: contact
    )
  end

  def initialize(id:, github: nil, surname_initials:, contact: nil)
    super(id: id, github: github)
    @surname_initials = surname_initials
    @contact = contact
  end

  def get_info
    contacts = []
    contacts << "GitHub: #{github}" if github
    contacts << "Контакт: #{@contact}" if @contact
    contacts_info = contacts.join(', ')

    "#{@surname_initials} (#{contacts_info})"
  end
end
