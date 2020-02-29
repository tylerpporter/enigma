require_relative 'cipher.rb'
require_relative 'shiftable.rb'

class Enigma < Cipher
  include Shiftable

  def initialize
    super
  end

  def encrypt(message, key = random_num, date = today)
    encrypted = cipher(message, key, date)
    clear
    {encryption: encrypted, key: key, date: date}
  end

  def decrypt(message, key, date = today)
    cipher(message, key, date, :decrypt)
  end

end
