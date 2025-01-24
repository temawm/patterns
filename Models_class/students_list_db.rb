require 'pg'
require_relative '../models/student'
require_relative '../models/student_short'
require_relative '../Pattern_Pattern/Data_list_student_short'
require_relative 'config'

class StudentsListDB
	def initialize(db_config)
    	@db_config = db_config
  	end

	def get_student_by_id(id)
		result = @db_config.execute_query("SELECT * FROM student WHERE id = $1", [id])
		raise ArgumentError, "Студент с ID #{id} не найден" if result.ntuples.zero?

		row = result.first.transform_keys(&:to_sym)
  		Student.from_hash(row)
	end

	def get_k_n_student_short_list(k, n, data_list = nil)
		raise ArgumentError, "Числа должны быть целыми и положительными" unless k.is_a?(Integer) && n.is_a?(Integer) && k > 0 && n > 0

		start = (k - 1) * n
		result = @db_config.execute_query('SELECT * FROM student ORDER BY id LIMIT $1 OFFSET $2', [n, start])
		students_short = result.map do |student|
			student = student.transform_keys(&:to_sym)
			StudentShort.from_student(Student.from_hash(student))
	    end
	    data_list ||= DataListStudentShort.new(students_short)
	    data_list
	end

	def add_student(student)
		begin
			result = @db_config.execute_query("INSERT INTO student (last_name, first_name, middle_name, git, phone_number, email, telegram)
				VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING id", student_fields(student))

			Student.new(
				id: result[0]['id'].to_i,
					last_name: student.last_name,
			    first_name: student.first_name,
			    middle_name: student.middle_name,
			    git: student.git,
			    phone_number: student.phone_number,
			    email: student.email,
			    telegram: student.telegram
			)
		rescue PG::UniqueViolation => e
			raise ArgumentError, "Такой студент уже существует"
		end
	end

	def replace_student_by_id(id, new_student)
		existing = @db_config.execute_query("SELECT 1 FROM student WHERE id = $1", [id])
  		raise ArgumentError, "Студент с ID #{id} не найден" if existing.ntuples.zero?
  		
		begin
			@db_config.execute_query("UPDATE student SET last_name = $1, first_name = $2, middle_name = $3, 
				git = $4, phone_number = $5, email = $6, telegram = $7 WHERE id = $8",
				student_fields(new_student) + [id]
			)
		rescue PG::UniqueViolation => e
			raise ArgumentError, "Такой студент уже существует"
		end
	end

	def remove_student_by_id(id)
		result = @db_config.execute_query("DELETE FROM student WHERE id = $1", [id])
	end

	def get_student_short_count
    	result = @db_config.execute_query("SELECT COUNT(*) AS count FROM student")
    	result[0]['count'].to_i
  	end

  	private

  	def student_fields(student)
    	[
    		student.last_name, student.first_name, student.middle_name, student.git,
    		student.phone_number, student.email, student.telegram
    	]
  	end
end