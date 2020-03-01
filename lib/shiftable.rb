require 'date'

module Shiftable
  ALPHABET = ("a".."z").to_a << " "
  ALPHABET_HASH = ALPHABET.zip((1..27).to_a).to_h

  def hash_it(array)
    return "NOPE" if array.size != 4
    %i(A B C D).zip(array).to_h
  end

  def today
    Date.today.strftime("%d%m%y")
  end

  def random_num
    rand(1000...99999).to_s.rjust(5, "0")
  end

  def shifted(shift)
    ALPHABET.rotate(shift).join
  end

  def key_generator(num)
    shfts = []
    num.chars.each_cons(2) {|key| shfts << key.join}
    hash_it(shfts)
  end

  def offset_generator(date)
   return "NOPE" if date.length != 6
   offsets = (date.to_i ** 2).to_s[-4..-1].chars
   hash_it(offsets)
  end

 def shift_generator(generated_keys, offsets)
   generated_keys.merge(offsets) do |key, key_value, offset_value|
     key_value.to_i + offset_value.to_i
   end
 end

end
