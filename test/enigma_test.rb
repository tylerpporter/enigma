require_relative 'test_helper.rb'
require './lib/enigma.rb'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end
  
  def test_it_has_constants
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
    assert_equal expected, Enigma::ALPHABET
    expected = {
     "a"=>1,
     "b"=>2,
     "c"=>3,
     "d"=>4,
     "e"=>5,
     "f"=>6,
     "g"=>7,
     "h"=>8,
     "i"=>9,
     "j"=>10,
     "k"=>11,
     "l"=>12,
     "m"=>13,
     "n"=>14,
     "o"=>15,
     "p"=>16,
     "q"=>17,
     "r"=>18,
     "s"=>19,
     "t"=>20,
     "u"=>21,
     "v"=>22,
     "w"=>23,
     "x"=>24,
     "y"=>25,
     "z"=>26,
     " "=>27
    }
    assert_equal expected, Enigma::ALPHABET_HASH
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_has_attributs
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
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
    expected = {
      encryption: "vjqtbeaweqihssi",
      key: "08304",
      date: "291018"
      }
      assert_equal expected, @enigma.encrypt("hello world end", "08304", "291018")
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

  def test_it_can_decrypt_a_message_with_given_key_and_no_date
    Date.stubs(:today).returns(Date.new(1995,8,4))
    encrypted = @enigma.encrypt("hello world", "02715")
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, @enigma.decrypt(encrypted[:encryption], "02715")
  end

  def test_it_can_handle_special_characters
    encrypted = @enigma.encrypt("hEll0...wo^!d", "02715", "040895")
    decrypted = @enigma.decrypt(encrypted[:encryption], "02715", "040895")
    assert_equal "hell0...wo^!d", decrypted[:decryption]
  end

  def test_it_can_crack_an_encryption_no_key_no_date
    encrypted = @enigma.encrypt("hello world end", "08304", "291018")
    expected = {
      decryption: "hello world end",
      key: nil,
      date: nil
    }
    assert_equal expected, @enigma.crack(encrypted[:encryption])
    encrypted = @enigma.encrypt("The Eagle Has Landed end")
    expected = {
      decryption: "the eagle has landed end",
      key: nil,
      date: nil
    }
    assert_equal expected, @enigma.crack(encrypted[:encryption])
  end

end
