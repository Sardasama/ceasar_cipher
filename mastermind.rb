#TODO : revise hints

class Game
  attr_accessor :turn
  attr_reader :colors, :code, :codeFound

  def initialize 
    @colors = ["R", "G", "B", "Y", "W", "V"]
    @turn = 0
    codeFound = false
    #show_rules
  end
  
  def generate_random_code
    rngCode = colors.shuffle.first(4)
  end

  def play_as_CodeBreaker
    code = generate_random_code
    while !codeFound && turn < 12
      @turn += 1
      puts "Turn #{turn} on 12 !"
      validGuess = false
      while validGuess == false
        puts "Please input your guess, for instance : R,B,W,Y"
        guess = gets.chomp.split(",")
        validGuess = check_guess(guess)
      end
      analyze_guess(guess)      
    end
  end

  def play_as_CodeMaker
    @code = gets.chomp.split(",")
    guess_arr = Array.new
    result = Array.new
    
    while !codeFound && turn < 1200
      @turn += 1
      puts "Turn #{turn}, try your best Computer !"
      guess = generate_guess(result, guess)
      while guess_arr.include?(guess)
        guess = generate_guess(result, guess)
      end  
      
      guess_arr.push(guess)
      result = analyze_guess(guess)      
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
        if !colors.include?(color)
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
    print "#{code} <> #{guess}"
    if @code == guess
      @codeFound = true
      puts "You won ! You found the code ! #{guess}" if @codeFound
    else
      for i in 0..3
        if guess[i] == @code[i]
          found += 1 
        elsif @code.include?(guess[i])
          misplaced +=1
        end
      end
      puts "You found the right place for #{found} color(s) and have discovered #{misplaced} misplaced color(s)." 
      return_arr = [found, misplaced]
      return return_arr
    end
  end

  def generate_guess(result, previousGuess)
    if (result[0].to_i + result[1].to_i) == 4
      guess = previousGuess.shuffle      
    elsif (result[0].to_i + result[1].to_i).between?(1,3)
      guess = previousGuess.shuffle.first(3).push(colors.shuffle[0])   
    else
      guess = generate_random_code
    end
  end
  
  def show_rules
    puts "Welcome to my wonderful MasterMind game!"
    puts "A random code has been generated. It is composed of 4 unique letters, corresponding of 6 differents colors : R = red, G = green, B = blue, Y = yellow, W = white and V = violet."
    puts "You have 12 turns to guess the code. Each guess will give you hints about how close your are from the code :"
    puts "you will be told how many colors are at the right position, and how many are valid but misplaced."
  end
end

#Game
newGame = Game.new
#newGame.play_as_CodeBreaker
newGame.play_as_CodeMaker
