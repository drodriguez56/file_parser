require "./parser"
require "./person"
require "date"

input_files = ARGV
files = []
input_files.each do |file|
  files << Parser.import(file)
end
