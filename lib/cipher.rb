require_relative 'shiftable.rb'

class Cipher
  CRACK = [27, 5, 14, 4]
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

  def find_shift_amounts(encrypted_message)
    alphabet_nums = chars_to_nums(encrypted_message).zip(CRACK)
    alphabet_nums.map {|num| (num[0] - num[1])}
  end

  def shift_assignments(encrypted_message)
    shifts = find_shift_amounts(encrypted_message[-4..-1])
    shift_hash = hash_it(shifts) if encrypted_message.size % 4 == 0
    shift_hash = hash_it(shifts.rotate(-1)) if encrypted_message.size % 4 == 1
    shift_hash = hash_it(shifts.rotate(-2)) if encrypted_message.size % 4 == 2
    shift_hash = hash_it(shifts.rotate(-3)) if encrypted_message.size % 4 == 3
    shift_hash
  end

  def rotate_chars(message, shift, type = :encrypt)
    if !message[0].nil?
      shift = (-shift) if type == :decrypt
      @new_message << message[0].tr(ALPHABET.join, shifted(shift))
      message.shift
    end
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

  def cipher(message, key, date, type = :encrypt)
    if key.nil? && date.nil?
      shifts = shift_assignments(message).values
    else
      shifts = shift_generator(key_generator(key), offset_generator(date)).values
    end
    message = message.downcase.chars
    create_new_message(message, shifts, type)
  end

end
