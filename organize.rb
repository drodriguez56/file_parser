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

users_list.each do |person|
  person.each do |data|
    data.chop! if data.include?("\n")
    data.gsub!("-", "/") if data.include?("-")
  end
  if person.count > 5
    person.delete_at(2)
    if person[2] == "M"
      person[2] = "Male"
    else
      person[2] = "Female"
    end
  end
  if person.last.include?("/")
    birthdate = person.pop
    color = person.pop
    person << birthdate
    person << color
  end

  if person[3].split("/")[1].to_i > 12
    date = person[3].split("/")
    month = date.shift
    day = date.shift
    date.unshift(month).unshift(day)
    date
    person[3] = date.join("/")
  end
end

option_1 = users_list.sort do |x,y|
  c = x[2] <=> y[2]
  c.zero? ? (x[0] <=> y[0]) : c
end

option_2 = users_list.sort do |x,y|
  case_1 = Date.parse(x[3])
  case_2 = Date.parse(y[3])
  c = case_1 <=> case_2
end

option_3 = users_list.sort do |x,y|
  c = y[0] <=> x[0]
end

option_1.map! do |list|
  list.join(" ")
end

option_2.map! do |list|
  list.join(" ")
end

option_3.map! do |list|
  list.join(" ")
end

options = [option_1, option_2, option_3]

Parser.export(options)
