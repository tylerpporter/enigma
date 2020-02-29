require_relative 'test_helper.rb'
require './lib/enigma.rb'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_has_attributs
    expected = [
     "a",
     "b",
     "c",
     "d",
     "e",
     "f",
     "g",
     "h",
     "i",
     "j",
     "k",
     "l",
     "m",
     "n",
     "o",
     "p",
     "q",
     "r",
     "s",
     "t",
     "u",
     "v",
     "w",
     "x",
     "y",
     "z",
     " "
    ]
    assert_equal expected, @enigma.alphabet
    assert_equal [], @enigma.new_message
  end

  def test_it_generates_the_date_as_string
    Date.stubs(:today).returns(Date.new(2020,2,27))
    assert_equal "270220", @enigma.today
  end

  def test_it_generates_random_0_padded_5_digit_number_as_string
    @enigma.stubs(:rand).returns(2715)
    assert_equal "02715", @enigma.random_num
  end

  def test_it_can_encrypt_a_message_with_given_key_and_date
    expected1 = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    assert_equal expected1, @enigma.encrypt("hello world", "02715", "040895")
    expected2 = {
      encryption: "vjqtbeaweqihssi",
      key: "08304",
      date: "291018"
      }
      assert_equal expected2, @enigma.encrypt("hello world end", "08304", "291018")
  end

  def test_it_can_encrypt_a_message_with_given_key_and_no_date
    Date.stubs(:today).returns(Date.new(1995,8,4))
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, @enigma.encrypt("hello world", "02715")
  end

  def test_it_can_encrypt_a_message_with_no_date_and_no_key
    Date.stubs(:today).returns(Date.new(1995,8,4))
    @enigma.stubs(:rand).returns(2715)
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, @enigma.encrypt("hello world")
  end

  def test_it_can_decrypt_a_message_with_given_key_and_date
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, @enigma.decrypt("keder ohulw", "02715", "040895")
  end

end
