def ceasar_cipher(string = "", shift_factor = 0)
  # Creates an array of the alphabet
  alphabet = ("a".."z").to_a
  # Transforms (using map) each letter of the input string (converted into an array using split) into the shifted one
  crypted_arr = string.split(//).map do |letter|
    # If the letter is not in the alphabet, it is returned as it is ("!" for instance)
    if alphabet.index(letter.downcase) != nil
      # Else the new index corresponding to the target letter is calculated
      new_index = alphabet.index(letter.downcase) - shift_factor.to_i
      # If the original letter is uppercase, the target one is upcased too
      letter = letter == letter.upcase ? alphabet[new_index].upcase : alphabet[new_index]
    end
    letter
  end
  # Returns the crypted string (using join on the array)
  crypted_string = crypted_arr.join
  # for testing purposes
  print crypted_string
end
