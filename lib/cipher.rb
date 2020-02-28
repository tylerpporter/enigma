require_relative 'shiftable.rb'

class Cipher
  include Shiftable
  attr_reader :alphabet

  def initialize
    @alphabet = ("a".."z").to_a << " "
  end

  def encrypt(message, key = random_num, date = today)
    shifts = shift_generator(key_generator(key), offset_generator(date)).values
    filtered_message = message.downcase.chars
    encrypted = []
    loop do shifts.each do |shift|
        if !filtered_message[0].nil?
          encrypted << filtered_message[0].tr(alphabet.join, alphabet.rotate(shift).join)
          filtered_message.shift
        end
      end
      break if filtered_message.empty?
    end
    encrypted.join
  end

end
