require_relative 'cipher.rb'
require_relative 'shiftable.rb'

class Enigma < Cipher
  include Shiftable

  def initialize
    super
  end

  def encrypt(message, key = random_num, date = today)
    encrypted = cipher(message, key, date)
    clear_message
    {encryption: encrypted, key: key, date: date}
  end

  def decrypt(endcrypted_message, key, date = today)
    decrypted = cipher(endcrypted_message, key, date, :decrypt)
    clear_message
    {decryption: decrypted, key: key, date: date}
  end

  def crack(message)
    cracked = cipher(message, nil, nil, :decrypt)
    clear_message
    {decryption: cracked, key: nil, date: nil}
  end

end
