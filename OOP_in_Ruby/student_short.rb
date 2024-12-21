require_relative 'person'

class StudentShort < Person
  attr_reader :id, :initials, :contact

  private_class_method :new

  def self.from_student(student)
    new(
      id: student.id,
      github: student.github,
      initials: student.initials,
      contact: student.phone || student.telegram || student.email
    )
  end

  def self.from_contact_info(id, contact_info)
    match = contact_info.match(/(.+?)\s+(.+?), GitHub: (.+?), Телефон: (.+?), Telegram: (@\w+)/)
    raise ArgumentError, "Некорректный формат строки contact_info" unless match

    initials = "#{match[1]} #{match[2][0]}."
    contact = match[4] || match[5]

    new(
      id: id,
      github: match[3],
      initials: initials,
      contact: contact
    )
  end

  def initialize(id:, initials:, contact: nil, github: nil)
    super(id: id, github: github)
    @initials = initials
    @contact = contact
  end
  
  def get_info()
    "#{@initials} #{github} Контакт: #{@contact}"
  end 

end
