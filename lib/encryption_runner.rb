require_relative './enigma.rb'

class Runner

  def self.encrypt
    file_a = File.open(ARGV[0], "r")
    message = file_a.read
    enigma = Enigma.new
    @@encryption = enigma.encrypt(message.strip)
    file_a.close
  end

  def self.write_encryption
    file_b = File.open(ARGV[1], "w")
    file_b.write(@@encryption[:encryption])
    file_b.close
    puts "Created '#{ARGV[1]}' with the key #{@@encryption[:key]} and date #{@@encryption[:date]}"
  end

end
