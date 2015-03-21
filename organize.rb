require "./parser"
require "./person"
require "date"

input_files = ARGV
files = []
input_files.each do |file|
  files << Parser.import(file)
end
users_list = []
files.each do |file|
  file.each do |person|
    if person.include?(",")
      users_list << person.split(", ")
    elsif person.include?(" | ")
      users_list << person.split(" | ")
    else person.include?(" ")
      users_list << person.split(" ")
    end
  end
end
