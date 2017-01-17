def stage_words(mode_selected)
  word_source = File.readlines('/usr/share/dict/words')
  word_list = word_source.map { |word| word.chomp.downcase}
  case mode_selected
  when "Easy"
    filtered_words = word_list.select {|word| word.length >= 4 && word.length <= 6}
  when "Normal"
    filtered_words = word_list.select {|word| word.length >= 6 && word.length <= 8}
  when "Hard"
    filtered_words = word_list.select {|word| word.length >= 8}
  end
end

def get_user_mode
  mode_selected = ""
  puts "Select your game mode (1-Easy, 2-Normal, 3-Hard): "
  while mode_selected.nil? || mode_selected.empty?
    mode_selected = gets.chomp
  end
  is_mode_valid?(mode_selected)
end

def is_mode_valid?(entered_mode)
  valid_modes = {"1" => "Easy", "2" => "Normal", "3" => "Hard"}
  if not valid_modes.key?(entered_mode)
    puts "Enter the number 1, 2, or 3 to select a mode."
    get_user_mode
  end
  valid_modes[entered_mode]
end

def get_word_mask(word_length)
  word_mask = Array.new(word_length, "_")
  word_mask.join
end

def validate_guess(guess)
  valid = "no"
  while valid == "no"
    if /[A-Za-z]/ === guess
      valid = "yes"
    else
      puts "Please enter a valid letter: "
      guess = gets.chomp.downcase
    end
  end
  guess
end

def search_game_word(valid_guess, game_word)
  index_of_matches = (0 ... game_word.length).find_all { |i| game_word[i] == valid_guess }
end

def main
  current_mask = ""
  letters_guessed = []
  number_of_guesses = 8
  mode_selected = get_user_mode
  word_list = stage_words(mode_selected)
  game_word = word_list.sample

  puts "Let's begin the game!"
  puts "Your word has " + game_word.length.to_s + " letters."

  while number_of_guesses > 0
    puts "Guess a letter: "
    guess = gets.chomp.downcase
    validated_guess = validate_guess(guess)
    if letters_guessed.include?(validated_guess)
      puts "You have already guessed that letter. You still have " + number_of_guesses.to_s + " guesses left."
    end
    letters_guessed << validated_guess
    search_results = search_game_word(validated_guess,game_word)
    if search_results.count > 0
      puts "Correct guess! You still have " + number_of_guesses.to_s + " guesses left."
    else
      number_of_guesses -= 1
      puts "Letter was not found. " + number_of_guesses.to_s + " guesses left."
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  main
end
