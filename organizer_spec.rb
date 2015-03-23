require_relative 'organizer'
require_relative 'person'

describe Organizer do

  let(:organizer) { Organizer.new }

  describe "Get files" do

    context "valid file" do
      it "should return an Array" do
          expect(organizer.get_files(["comma_delimited.txt"])).to be_instance_of(Array)
      end
    end
  end

  describe "Extract Users" do
    let(:files){ organizer.extract_users([["Rodriguez, Daniel, Male, Black, 10/10/1023"],
      ["Calero | Jhon | M | M | Green | 10/12/1423"]]) }
    it "should return an Array" do
      expect(files).to be_instance_of(Array)
    end

    it "should not be empty" do
      expect(files).not_to be_empty
    end

    it "shuld be a list of person objects" do
      files.each{ |person| expect(person).to be_instance_of(Person) }
    end

  end


  describe "Sort" do
      let(:user_list) { [["Bonk", "Radek", "Male", "6/3/1975","Green"],
      ["Kournikova", "Anna", "Female", "6/3/1975", "Red"],
      ["Bouillon", "Francis", "Male", "6/3/197"],
      ["Seles", "Monica", "Female", "12/2/1973", "Black"],
      ["Abercrombie", "Neil", "Male", "2/13/1943", "Tan"],
      ["Kelly", "Sue", "Female", "7/12/1959", "Pink"],
      ["Bishop", "Timothy", "Male", "4/23/1967", "Yellow"]] }

    context "Sort by gender and first name ascending" do

      it "shuld return an array of length 7" do
        expect(organizer.sotr_by_gender_and_first_name_ascending(user_list).length).to be(7)
      end
       it "should sort data Female first and by name ascending" do
         expect(organizer.sotr_by_gender_and_first_name_ascending(user_list)[2]).to eq(["Seles", "Monica", "Female", "12/2/1973", "Black"])
       end
    end

    context "sort by birthdate ascending" do

      it "shuld return an array of length 7" do
        expect(organizer.sotr_by_gender_and_first_name_ascending(user_list).length).to be(7)
      end
      it "should sort data by birthdate ascending" do
         expect(organizer.sort_by_birthdate_ascending(user_list)[2]).to eq(["Kelly", "Sue", "Female", "7/12/1959", "Pink"])
       end

    end

    context "Sort by name descending" do

      it "shuld return an array of length 7" do
        expect(organizer.sotr_by_gender_and_first_name_ascending(user_list).length).to be(7)
      end
      it "should sort data by last name descending" do
         expect(organizer.sort_by_last_name_descending(user_list)[4]).to eq(["Bonk", "Radek", "Male", "6/3/1975","Green"])
       end

    end

  end

  describe "Join data" do
    let(:user) { [["Bonk", "Radek", "Male", "6/3/1975","Green"]] }

    it "should join data into single string" do
         expect(organizer.join_data(user)).to eq(["Bonk Radek Male 6/3/1975 Green"])
    end


  end

  describe "Save Lost" do
    it "shuld create a new file" do
      organizer.save_list([["hello"],["world"]], "test")
      expect(File.file?('test.txt')).to be(true)
    end

  end

end


describe Person do
  let(:person) { Person.new({first_name: "Daniel", last_name: "Rodriguez", gender: "Male", birthdate: "10/12/1933" , favorite_color: "Green"})}

  describe "create person" do

    it "hould create a person" do
      expect(person).to be_instance_of(Person)
    end
  end

end

describe PersonParser do
  let(:person_string) { "Rodriguez, Daniel, Male, Black, 10/08/1023" }
  describe "person from line" do
    it "should return a instance of person" do
      expect(PersonParser.person_from_line(person_string, ",")).to be_instance_of(Person)
    end

    it "should return a person" do
      person = PersonParser.person_from_line(person_string, ",")
      expect(person.first_name).to eq("Daniel")
      expect(person.birthdate.strftime("%Y-%m-%d")).to eq("1023-10-08")
    end
  end

end
