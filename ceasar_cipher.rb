def ceasar_cipher(string, shift_factor)
  alphabet = "abcdefghijklmnopqrstuvwxyz"
  alphabet_arr = alphabet.split(//)
  string_arr = string.split(//)
  crypted_arr = string_arr.map do |letter|
    if alphabet_arr.index(letter.downcase) != nil
      new_index = alphabet_arr.index(letter.downcase) - shift_factor.to_i
      letter = letter == letter.upcase ? alphabet_arr[new_index].upcase : alphabet_arr[new_index]
    end
    letter
  end
  crypted_string = crypted_arr.join
  print crypted_string
end
