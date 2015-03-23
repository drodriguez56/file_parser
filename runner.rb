require "./organize"


organizer = Organizer.new
input_files = ARGV
if input_files.length == 0
  puts "Please write the complete file(s) name(s) separated by spaces after organizer.rb"
  puts "ex: runner.rb first_file.txt next_file.txt n_file.txt"
else
  files = organizer.get_files(input_files)
  data = organizer.extract_users(files)
  users_list = organizer.organize_data(data)
  output_1 = organizer.join_data(organizer.sotr_by_gender_and_first_name_ascending(users_list))
  output_2 = organizer.join_data(organizer.sort_by_birthdate_ascending(users_list))
  output_3 = organizer.join_data(organizer.sort_by_last_name_descending(users_list))
  list =[output_1, output_2, output_3]
  organizer.save_list(list)
  puts "The resulting file was saved under the name of Output.txt in this same folder"
end