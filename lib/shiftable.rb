module Shiftable

  def today
    Date.today.strftime("%d%m%y")
  end

  def random_num
    rand(1000...99999).to_s.rjust(5, "0")
  end

  def key_generator(num)
    keys = %i(A B C D)
    shfts = []
    num.chars.each_cons(2) {|key| shfts << key.join}
    keys.zip(shfts).to_h
  end

end
