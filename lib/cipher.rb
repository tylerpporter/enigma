require_relative 'shiftable.rb'

class Cipher
  KNOWN_VALUES = [27, 5, 14, 4]
  include Shiftable
  attr_reader :new_message

  def initialize
    @new_message = []
  end

  def clear_message
    @new_message = []
  end

  def chars_to_nums(message)
    message.chars.inject([]) do |nums, char|
      ALPHABET_HASH[char].nil? ? nums << char : nums << ALPHABET_HASH[char]
      nums
    end
  end

  def rotate_chars(message, shift, type = :encrypt)
      shift = (-shift) if type == :decrypt
      @new_message << message[0].tr(ALPHABET.join, shifted(shift))
      message.shift
  end

  def create_new_message(message, shifts, type)
    loop do
      break if message[0].nil?
      shifts.each do |shift|
        break if message[0].nil?
        rotate_chars(message, shift, type)
      end
    end
    @new_message.join
  end

  def find_shift_amounts(encrypted_message)
    alphabet_nums = chars_to_nums(encrypted_message).zip(KNOWN_VALUES)
    alphabet_nums.map {|num| num[0] - num[1]}
  end

  def shift_assignments(encrypted_message)
    shifts = find_shift_amounts(encrypted_message[-4..-1])
    shift_assign = hash_it(shifts) if encrypted_message.size % 4 == 0
    shift_assign = hash_it(shifts.rotate(-1)) if encrypted_message.size % 4 == 1
    shift_assign = hash_it(shifts.rotate(-2)) if encrypted_message.size % 4 == 2
    shift_assign = hash_it(shifts.rotate(-3)) if encrypted_message.size % 4 == 3
    shift_assign
  end

  def which_shift_method(message, key, date)
    if key.nil? && date.nil?
      shift_assignments(message).values
    else
      shift_generator(key_generator(key), offset_generator(date)).values
    end
  end

  def cipher(message, key, date, type = :encrypt)
    shifts = which_shift_method(message, key, date)
    message = message.downcase.chars
    create_new_message(message, shifts, type)
  end

end
