require_relative 'shiftable.rb'

class Cipher
  include Shiftable 
  attr_reader :alphabet

  def initialize
    @alphabet = ("a".."z").to_a << " "
  end

end
