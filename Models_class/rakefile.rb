require 'active_record'
require 'sqlite3'
require 'rake'
require 'yaml'

# Загрузка конфигурации базы данных из database.yml
db_config = YAML.load_file('database.yml')

# Устанавливаем соединение с базой данных для разработки
ActiveRecord::Base.establish_connection(db_config['development'])

# Определение модели Student
class Student < ActiveRecord::Base
end

# Задачи для работы с базой данных
namespace :db do
  desc 'Создать базу данных'
  task :create do
    ActiveRecord::Base.establish_connection
    ActiveRecord::Migrator.migrate('db/migrate')
  end

  desc 'Сгенерировать миграцию'
  task :generate_migration do
    filename = '20250124000000_create_students.rb'  # Название миграции

    migration = <<~RUBY
    class CreateStudents < ActiveRecord::Migration[6.1]
      def change
        create_table :students do |t|
          t.string :last_name
          t.string :first_name
          t.string :middle_name
          t.string :phone
          t.string :telegram
          t.string :email
          t.string :github

          t.timestamps
        end
      end
    end
    RUBY

    File.open("db/migrate/#{filename}", 'w') do |f|
      f.write(migration)
    end
    puts "Migration file created: db/migrate/#{filename}"
  end
end
