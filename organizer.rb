require "./person"
require "date"

class Organizer

    def get_files input_files
      files = []
      input_files.each do |file|
        files << File.readlines(file)
      end
    return files
    end

    def extract_users files
      users_list = []
      files.each do |file|
        file.each do |line|
          separator = get_separator(line)
          users_list << PersonParser.person_from_line(line, separator)
        end
      end
      return users_list
    end

    def sotr_by_gender_and_first_name_ascending users_list
      users_list.sort do |x,y|
        c = x[2] <=> y[2]
        c.zero? ? (x[0] <=> y[0]) : c
      end
    end

    def sort_by_birthdate_ascending users_list
      users_list.sort do |x,y|
        c =  Date.strptime(x[3], "%m/%d/%Y") <=> Date.strptime(y[3], "%m/%d/%Y")
      end
    end

    def sort_by_last_name_descending users_list
      users_list.sort do |x,y|
        c = y[0] <=> x[0]
      end
    end

    def join_data data
      data.map! do |list|
        list.join(" ")
      end
    end

    def save_list list, name
      File.new("#{name}.txt", "w+")
        File.open("#{name}.txt", "a") do |file|
          (1..list.length).each do |num|
            file.write("#{name} #{num}: \n")
            file.puts(list[num-1])
            file.write("\n")
          end
        end
    end

    private

      def get_separator person
        separator = /\W../.match(person).to_s

        if separator.match(/\w/) != nil
          separator = separator.chomp(separator.match(/[a-zA-Z]+/).to_s)
            if separator != " "
              return separator.strip!
            else
              return separator
            end
        else
          return separator.strip!
        end

      end

end
