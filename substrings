def substrings(string, dictionary)
  str_arr = string.downcase!.split(" ")
  my_hash = Hash.new
  dictionary.each do |word| 
    str_arr.each do |str_word|
      my_hash[word] = my_hash[word].to_i + 1 if str_word.include?(word)
    end
  end
  my_hash.compact
  puts my_hash
end
