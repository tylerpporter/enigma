require './lib/enigma.rb'

class Runner

  def self.encrypt
    file = File.open(ARGV[0], "r")
    message = file.read
    enigma = Enigma.new
    @@encryption = enigma.encrypt(message.strip)
    file.close
  end

  def self.write_encryption
    file = File.open(ARGV[1], "w")
    file.write(@@encryption[:encryption])
    file.close
    puts "Created '#{ARGV[1]}' with the key #{@@encryption[:key]} and date #{@@encryption[:date]}"
  end

  def self.decrypt
    file = File.open(ARGV[0], "r")
    message = file.read
    enigma = Enigma.new
    @@decryption = enigma.decrypt(message.strip, ARGV[2], ARGV[3])
    file.close
  end

  def self.write_decryption
    file = File.open(ARGV[1], "w")
    file.write(@@decryption[:decryption])
    file.close
    puts "Created '#{ARGV[1]}' with the key #{@@decryption[:key]} and date #{@@decryption[:date]}"
  end

  def self.crack
    file = File.open(ARGV[0], "r")
    message = file.read
    enigma = Enigma.new
    @@cracked = enigma.crack(message.strip)
    file.close
  end

  def self.write_crack
    file = File.open(ARGV[1], "w")
    file.write(@@cracked[:decryption])
    file.close
    puts "Created '#{ARGV[1]}' without a key or date"
  end

end
