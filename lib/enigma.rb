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

  def decrypt(endcrypted_message, key, date = today)
    decrypted = cipher(endcrypted_message, key, date, :decrypt)
    clear
    {decryption: decrypted, key: key, date: date}
  end

  def crack(message)
    cracked = cipher(message, nil, nil, :decrypt)
    clear
    {decryption: cracked, key: key, date: date}
  end

end
