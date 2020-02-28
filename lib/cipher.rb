require_relative 'shiftable.rb'

class Cipher
  include Shiftable
  attr_reader :alphabet

  def initialize
    @alphabet = ("a".."z").to_a << " "
    @encrypted = []
  end

  def shifted(shift)
    @alphabet.rotate(shift).join
  end

  def cipher(message, key = random_num, date = today, type = :encrypt)
    shifts = shift_generator(key_generator(key), offset_generator(date)).values
    message = message.downcase.chars
    shifts.each do |shift|
      if !message[0].nil?
        shift = (-shift) if type == :decrypt
        @encrypted << message[0].tr(alphabet.join, shifted(shift))
        message.shift
      end
    end
    message = message.join if message != ""
    cipher(message, key, date, type) if message != ""
    @encrypted.join
  end

end
