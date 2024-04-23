class Game
  attr_accessor :turn
  attr_reader :colors_list, :code, :code_found

  def initialize 
    @colors_list = ["R", "G", "B", "Y", "W", "V"]
    @turn = 0
    @code_found = false
    @code = Array.new(4, "")
    show_rules
  end
  
  def generate_random_code
    rng_code = colors_list.shuffle.first(4)
  end

  def play_as_codebreaker
    @code = generate_random_code
    #Rules
    puts "A random code has been generated. It is composed of 4 unique letters, corresponding of 6 differents colors : R = red, G = green, B = blue, Y = yellow, W = white and V = violet."
    puts "You have 12 turns to guess the code. Each guess will give you hints about how close your are from the code :"
    puts "you will be told how many colors are at the right position, and how many are valid but misplaced."
    
    while !@code_found && @turn < 12
      @turn += 1
      puts "Turn #{turn} on 12 !"
      valid_guess = false
      while valid_guess == false
        puts "Please input your guess, for instance : R,B,W,Y (or restart or exit)"        
        input = gets.chomp
        if input == "restart" 
          newGame = Game.new
        elsif input == "exit"
          abort("Thanks for playing !")
        else
          valid_guess = check_guess(guess = input.split(","))
        end  
      end
      analyze_guess(guess)      
    end
  end

  def play_as_codemaker
    puts "Please enter a code composed of 4 unique letters, corresponding of 6 differents colors : R = red, G = green, B = blue, Y = yellow, W = white and V = violet."
    puts "The computer will try to guess in the less turns possible."
    @code = gets.chomp.split(",")
    
    guess_hash = Hash.new
    hints = Array.new(2, 0)
    
    while !@code_found && turn < 1200
      @turn += 1
      puts "Turn #{turn}, try your best Computer !"
      guess = generate_guess(hints, guess)
      while guess_hash.include?(guess)
        guess = generate_guess(hints, guess)
      end  
      hints = analyze_guess(guess) 
      guess_hash[guess] = hints
    end
    
  end

  def check_guess(guess)
    if guess != guess.uniq
      puts "Invalid guess : Each color should only appear once."
      return false
    elsif guess.count != 4
      puts "Invalid guess : Your guess should consist of 4 colors."
      return false
    elsif
      guess.each do |color|
        if !colors_list.include?(color)
          puts "#{color} is not listed in the valid colors. Please use only one of those : #{colors}"
          return false
        end
      end
    else
      return true    
    end
  end

  def analyze_guess(guess)
    found = 0
    misplaced = 0
    print "#{guess}"
    if @code == guess
      @code_found = true
      if @code_found
        puts "You won ! You found the code ! #{guess}"
        puts "Wanna play again? (Y/N)"
        Game.new if gets.chomp.upcase == "Y"
      end
    else
      for i in 0..3
        if guess[i] == @code[i]
          found += 1 
        elsif @code.include?(guess[i])
          misplaced +=1
        end
      end
      print "You found the right place for #{found} color(s) and have discovered #{misplaced} misplaced color(s). \n" 
      hints = [found, misplaced]
      return 
    end
  end

  def generate_guess(hints, last_guess)
    colors_pool = Array.new
    if hints[0] + hints[1] == 4
      guess = last_guess.shuffle
    else
      guess = generate_random_code
    end
  end
  
  def show_rules
    puts "Welcome to my wonderful MasterMind game!"
    puts "Do you want to play as the Code Breaker (type 1) or the Code Maker (type 2) ?"
    role = gets.chomp.to_i
    role == 1 ? play_as_codebreaker : play_as_codemaker
  end
end

#Game
Game.new
