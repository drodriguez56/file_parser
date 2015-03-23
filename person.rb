class Person
  attr_reader :first_name, :last_name, :initial, :gender, :birthdate, :favorite_color
  def initialize(args)
     @first_name = args[:first_name]
     @last_name = args[:last_name]
     @initial = args[:initial]
     @gender = args[:gender]
     @birthdate = args[:birthdate]
     @favorite_color = args[:favorite_color]
  end

  def to_s
    return [@last_name, @first_name, @gender, @birthdate.strftime("%m/%d/%Y"), @favorite_color]
  end

end

module PersonParser

   FORMATS = {
     "," => [:last_name, :first_name, :gender, :favorite_color, :birthdate],
     "|" => [:last_name, :first_name, :initial, :gender, :favorite_color, :birthdate],
     " " =>  [:last_name, :first_name, :initial, :gender, :birthdate, :favorite_color],
   }

   def self.person_from_line(line, separator)
    format = FORMATS[separator]
    arr = line.split(separator)
    arr.each{|entry| entry.strip!}
    person_hash = Hash.new
    format.each_with_index do |field, index|
       if field == :birthdate
          person_hash[field] = date_from_string(arr[index])
       elsif field == :gender
          person_hash[field] = standarize_gender(arr[index])
       else
          person_hash[field] = arr[index]
       end
    end
    person = Person.new(person_hash)
  end

  private

    def self.date_from_string str
        str = str.gsub('-', '/')
        return Date.strptime(str, "%m/%d/%Y")
    end

    def self.standarize_gender str
      if str == "M"
         "Male"
      elsif str == "F"
         "Female"
      else
        str
      end
    end


end