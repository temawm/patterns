class Student < Person
  def initialize(id:, last_name:, first_name:, middle_name:, phone: nil, telegram: nil, email: nil, github: nil)
    super(id: id, last_name: last_name, first_name: first_name, middle_name: middle_name, phone: phone, telegram: telegram, email: email, github: github)
  end

  def get_info
    contacts = []
    contacts << "GitHub: #{@github}" if @github
    contacts << "Телефон: #{@phone}" if @phone
    contacts << "Telegram: #{@telegram}" if @telegram
    contacts_info = contacts.join(', ')

    "#{@last_name} #{@first_name[0]}.#{@middle_name[0]}. (#{contacts_info})"
  end
end
