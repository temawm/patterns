require 'mysql2'

class DBConnection
  def self.client
    @client ||= Mysql2::Client.new(
      host: 'localhost', 
      username: 'root', 
      password: '11111111', 
      database: 'students_db'
    )
  end
end
