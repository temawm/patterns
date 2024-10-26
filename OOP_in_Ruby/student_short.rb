class Student_short < Person
  attr_reader :contact_info

  def initialize(id: nil, contact_info: nil, student: nil)
    if [id, contact_info].all? && student
      raise ArgumentError, "Необходимо передать либо объект student, либо id и contact_info, но не все сразу"
    end

    if student
      super(id: student.id, last_name: student.last_name, first_name: student.first_name,
            middle_name: student.middle_name, phone: student.phone, telegram: student.telegram,
            email: student.email, github: student.github)
      @contact_info = generate_contact_info
    elsif id && contact_info
      parse_contact_info(id, contact_info)
    else
      raise ArgumentError, "Необходимо передать либо объект student, либо id и contact_info"
    end
  end

  private

  def generate_contact_info
    contacts = []
    contacts << "GitHub: #{@github}" if @github
    contacts << "Телефон: #{@phone}" if @phone
    contacts << "Telegram: #{@telegram}" if @telegram
    contacts.join(', ')
  end

  def parse_contact_info(id, contact_info)
    @id = id
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
end
