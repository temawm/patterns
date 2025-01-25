require 'json'

def make_ids_incremental(json_data)
  max_id = json_data.map { |entry| entry['id'] }.max
  ids_seen = {}

  json_data.each do |entry|
    current_id = entry['id']
    
    if ids_seen[current_id]
      max_id += 1
      entry['id'] = max_id
    end
    
    ids_seen[entry['id']] = true
  end

  json_data
end


file_path = 'C:/Users/temaf/NotepadFiles/Models_class/student.json'


json_data = JSON.parse(File.read(file_path))


unique_data = make_ids_incremental(json_data)


File.write('C:/Users/temaf/NotepadFiles/Models_class/student.json', JSON.pretty_generate(unique_data))


