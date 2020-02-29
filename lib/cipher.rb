require_relative 'shiftable.rb'

class Cipher
  CRACK = [27, 5, 14, 4]
  include Shiftable
  attr_reader :alphabet,
              :new_message

  def initialize
    @alphabet = ("a".."z").to_a << " "
    @new_message = []
  end

  def clear
    @new_message = []
  end

  def alphabet_hash
    alphabet.zip((1..27).to_a).to_h
  end

  def chars_to_nums(message)
    message.chars.inject([]) do |nums, char|
      if alphabet_hash[char].nil?
        nums << char
      else
        nums << alphabet_hash[char]
      end
      nums
    end
  end

  def find_shift_amounts(encrypted_message)
    alphabet_nums = chars_to_nums(encrypted_message).zip(CRACK)
    alphabet_nums.map {|num| (num[0] - num[1]).abs}
  end

  def shift_assignments(encrypted_message)
    shifts = find_shift_amounts(encrypted_message[-4..-1])
    hash_it(shifts) if encrypted_message.size % 4 == 0
    hash_it(shifts.rotate(-1)) if encrypted_message.size % 4 == 1
    hash_it(shifts.rotate(-2)) if encrypted_message.size % 4 == 2
    hash_it(shifts.rotate(-3)) if encrypted_message.size % 4 == 3
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

end
