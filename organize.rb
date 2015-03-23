require "./parser"
require "date"

class Organizer

    def get_files input_files
      files = []
      input_files.each do |file|
        files << Parser.import(file)
      end
      return files
    end

    def extract_users files
      users_list = []
      files.each do |file|
        file.each do |person|
          separator = get_separator(person)
          if person.include?(separator)
            users_list << person.split(separator)
          end
        end
      end
      return users_list
    end

    def organize_data data
      data.each do |person|
        clean_format(person)
        standarize_gender(person)
        standarize_format(person)
        standarize_date(person)
      end
    end

    def sotr_by_gender_and_first_name_ascending users_list
      users_list.sort do |x,y|
        c = x[2] <=> y[2]
        c.zero? ? (x[0] <=> y[0]) : c
      end
    end

    def sort_by_birthdate_ascending users_list
      users_list.sort do |x,y|
        c = Date.parse(x[3]) <=> Date.parse(y[3])
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

    def save_list list
      Parser.export(list)
    end

    private

      def get_separator person
        separator = /\W../.match(person).to_s

        if separator.match(/\w/) != nil
          separator = separator.chomp(separator.match(/[a-zA-Z]+/).to_s)
          return separator
        else
          return separator
        end

      end

      def standarize_gender person
        if person.count > 5
            person.delete_at(2)
            if person[2] == "M"
              person[2] = "Male"
            else
              person[2] = "Female"
            end
          end
      end

      def clean_format person
        person.each do |data|
          data.chop! if data.include?("\n")
          data.gsub!("-", "/") if data.include?("-")
        end
      end

      def standarize_format person
        if person.last.include?("/")
            birthdate = person.pop
            color = person.pop
            person << birthdate
            person << color
          end
      end

      def standarize_date person
        if person[3].split("/")[1].to_i > 12
              date = person[3].split("/")
              month = date.shift
              day = date.shift
              date.unshift(month).unshift(day)
              date
              person[3] = date.join("/")
            end
      end

end
