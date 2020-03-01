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
    assert_equal [], @cipher.new_message
  end

  def test_it_can_shift_and_join_the_alphabet
    expected = "bcdefghijklmnopqrstuvwxyz a"
    assert_equal expected, @cipher.shifted(1)
  end

  def test_it_can_create_an_alphabet_hash
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
    assert_equal expected, @cipher.alphabet_hash
  end

  def test_it_can_convert_characters_to_numbers
    assert_equal [1, 2, 3], @cipher.chars_to_nums("abc")
    assert_equal [1, 27, 2], @cipher.chars_to_nums("a b")
    # assert_equal [1, "!", 2], @cipher.chars_to_nums("a!b")
  end

  def test_it_can_create_a_hash_with_4_given_values
    expected1 = ({A: 0, B: 0, C: 0, D: 0})
    assert_equal expected1, @cipher.hash_it([0, 0, 0, 0])
    expected2 = ({A: "dog", B: 12, C: ["4"], D: :fish})
    assert_equal expected2, @cipher.hash_it(["dog", 12, ["4"], :fish])
    assert_equal "NOPE", @cipher.hash_it(["dog", 12])
  end

  def test_it_can_generate_keys
    expected = {
      A: "02",
      B: "27",
      C: "71",
      D: "15"
    }
    assert_equal expected, @cipher.key_generator("02715")
    assert_equal "NOPE", @cipher.key_generator("0125")
  end

  def test_it_can_generate_offsets
    expected = {
      A: "1",
      B: "0",
      C: "2",
      D: "5"
    }
    assert_equal expected, @cipher.offset_generator("040895")
    assert_equal "NOPE", @cipher.offset_generator("0578")
  end

  def test_it_can_generate_shifts
    keys = @cipher.key_generator("02715")
    offsets = @cipher.offset_generator("040895")
    expected = {
      A: 3,
      B: 27,
      C: 73,
      D: 20
    }
    assert_equal expected, @cipher.shift_generator(keys, offsets)
  end

  def test_it_can_rotate_characters_and_add_them_to_new_message
    @cipher.rotate_chars(%w(h e l l o), 3)
    assert_equal ["k"], @cipher.new_message
    @cipher.rotate_chars(%w(e l l o), 3)
    assert_equal ["k", "h"], @cipher.new_message
  end

  def test_it_can_encrypt_a_message_and_clear_it_out
    assert_equal "keder ohulw", @cipher.cipher("hello world", "02715", "040895")
    assert_equal ["k", "e", "d", "e", "r", " ", "o", "h", "u", "l", "w"], @cipher.new_message
    @cipher.clear
    assert_equal [], @cipher.new_message
    assert_equal "vjqtbeaweqi!njsl", @cipher.cipher("hello world! end", "08304", "291018")
  end

  def test_it_can_decrypt_a_message_with_date_and_key
    assert_equal "hello world", @cipher.cipher("keder ohulw", "02715", "040895", :decrypt)
    @cipher.clear
    assert_equal "hello world! end", @cipher.cipher("vjqtbeaweqi!njsl", "08304", "291018", :decrypt)
  end

  def test_it_can_find_shift_amounts_of_encrypted_message
    assert_equal [0, 0, 0, 0], @cipher.find_shift_amounts(" end")
    assert_equal [-26, 2, 3, 4], @cipher.find_shift_amounts("agqh")
  end

  def test_it_can_determine_shift_assignments_of_encrypted_message
    expected = {
      A: 14,
      B: 5,
      C: 5,
      D: -19
    }
    assert_equal expected, @cipher.shift_assignments("vjqtbeaweqihssi")
  end

  def test_it_can_decrypt_a_message_no_date_no_key
    assert_equal "hello world end", @cipher.de_cipher("vjqtbeaweqihssi")
  end

end
