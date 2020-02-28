module Shiftable

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

  def key_generator(num)
    shfts = []
    num.chars.each_cons(2) {|key| shfts << key.join}
    hash_it(shfts)
  end

  def offset_generator(date)
   offsets = (date.to_i ** 2).to_s[-4..-1].chars
   hash_it(offsets)
 end

end
