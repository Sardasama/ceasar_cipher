def ceasar_cipher(string, shift_factor)
  alphabet = "abcdefghijklmnopqrstuvwxyz"
  string_arr = string.split(//)
  crypted_arr = string_arr.map do |letter|
    if alphabet.index(letter.downcase) != nil
      new_index = alphabet.index(letter.downcase) - shift_factor.to_i
      letter = letter == letter.upcase ? alphabet[new_index].upcase : alphabet[new_index]
    end
    letter
  end
  crypted_string = crypted_arr.join
  print crypted_string
end
