require_relative 'cipher.rb'
require_relative 'shiftable.rb'

class Enigma < Cipher
  include Shiftable

  def initialize
    super
  end

  

end
