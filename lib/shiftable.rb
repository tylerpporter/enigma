module Shiftable

  def today
    Date.today.strftime("%d%m%y")
  end

  def random_num
    rand(1000...99999).to_s.rjust(5, "0")
  end

end
