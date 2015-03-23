require_relative 'organize'
require_relative 'parser'

describe Organizer do

  let(:organizer) { Organizer.new }

  describe "Get files" do

    context "valid file" do
      it "should return an Array" do
          expect(organizer.get_files(["comma_delimited.txt"])).to be_instance_of(Array)
      end
    end

    context "Invalid file" do
      xit "should return false if file is invalid" do
      end
    end
  end

  describe "Extract Users" do
    let(:files){ organizer.extract_users([["Rodriguez, Daniel, Male, 10/10/1023, black"]]) }
    it "should return an Array" do
      expect(files).to be_instance_of(Array)
    end

    it "should not be empty" do
      expect(files).not_to be_empty
    end

    it "shuld have the first entry of length 5" do
      files.each{ |entry| expect(entry.length).to be(5) }
    end

  end

  describe "Organize data" do

  end

  describe "Sort" do

    context "Sort by gender and first name ascending" do
    end

    context "sort by birthdate ascending" do
    end

    context "Sort by name descending" do
    end

  end

  describe "Join data" do

  end

  describe "Save list" do
  end

end

describe Parser do

  let(:file) { Parser.import("comma_delimited.txt") }

  context "Import" do
    it "shuld be an Array" do
       expect(file).to be_instance_of(Array)
    end

    it "shuild not be empty" do
      expect(file).not_to be_empty
    end

  end

  context "Export" do
    it "shuld create a new file" do
      Parser.export([["hello"],["world"]])
      expect(File.file?('output.txt')).to be(true)
    end

  end

end