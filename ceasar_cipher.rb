def ceasar_cipher(string, shift_factor)
  alphabet = "abcdefghijklmnopqrstuvwxyz"
  alphabet_arr = alphabet.split(//)
  string_arr = string.split(//)
  crypted_string = string_arr.map { |letter| letter = alphabet_arr[alphabet_arr.index(letter) - shift_factor.to_i]}
  print crypted_string
end
