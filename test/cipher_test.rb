require_relative 'test_helper.rb'
require './lib/cipher'

class CipherTest < Minitest::Test

  def setup
    @cipher = Cipher.new
  end

  def test_it_exists
    assert_instance_of Cipher, @cipher
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
    assert_equal expected, @cipher.alphabet
  end

  def test_it_generates_the_current_date_as_string
    assert_equal "270220", @cipher.today
  end

  def test_it_generates_random_0_padded_5_digit_number_as_string
    @cipher.stubs(:rand).returns(2715)
    assert_equal "02715", @cipher.random_num
  end

end
