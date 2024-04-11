def ceasar_cipher(string, shift_factor)
  alphabet = "abcdefghijklmnopqrstuvwxyz"
  alphabet_arr = alphabet.split(//)
  string_arr = string.split(//)
  crypted_string = string_arr.map do |letter|
    new_index = alphabet_arr.index(letter.downcase).to_i - shift_factor.to_i
    letter = letter == letter.upcase ? alphabet_arr[new_index].upcase : alphabet_arr[new_index]
  end
  print crypted_string
end
