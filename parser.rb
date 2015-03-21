module Parser

  def self.import file
    File.readlines(file)
  end

  def self.export options
    File.new("output.txt", "w+")
    File.open("output.txt", "a") do |file|
      (1..options.length).each do |num|
        file.write("Output #{num}: \n")
        file.puts(options[num-1])
        file.write("\n")
      end
    end
  end

end