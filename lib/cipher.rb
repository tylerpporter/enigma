require_relative 'shiftable.rb'

class Cipher
  include Shiftable
  attr_reader :alphabet,
              :new_message

  def initialize
    @alphabet = ("a".."z").to_a << " "
    @new_message = []
  end

  def shifted(shift)
    alphabet.rotate(shift).join
  end

  def rotate_chars(message, shift, type = :encrypt)
    if !message[0].nil?
      shift = (-shift) if type == :decrypt
      @new_message << message[0].tr(alphabet.join, shifted(shift))
      message.shift
    end
  end

  def cipher(message, key, date, type = :encrypt)
    shifts = shift_generator(key_generator(key), offset_generator(date)).values
    message = message.downcase.chars
    shifts.each do |shift|
      rotate_chars(message, shift, type)
    end
    message = message.join if message != ""
    cipher(message, key, date, type) if message != ""
    @new_message.join
  end

  def clear
    @new_message = []
  end

end
