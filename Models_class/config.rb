require 'pg'

class DBConfig

	DEFAULT_CONFIG = {
    dbname: 'Students',
    user: 'postgres',
    password: 'password',
    host: 'localhost',
    port: 5432
  }.freeze

  	@instance = nil

  	def self.instance
    	@instance ||= new
  	end

  	private_class_method :new

	private attr_reader :connection

	def initialize
		@connection = PG.connect(DEFAULT_CONFIG)
	end

	def execute_query(query, params = [])
	    connection.exec_params(query, params)
	end

	def close
		connection.close
	end
end