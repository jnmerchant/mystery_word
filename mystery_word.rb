##https://www.ruby-forum.com/topic/164161 - have a string call a method

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
    puts "Please enter the number 1, 2, or 3 to select a mode."
    get_user_mode
  end
  valid_modes[entered_mode]
end

def get_word_mask(word_length)
  word_mask = Array.new(word_length, "_")
  word_mask.join
end

def begin_game(game_word)
  puts "Let's begin the game!"
  puts "Your word has " + game_word.length.to_s + " letters."
  word_mask = get_word_mask(game_word.length)
  p word_mask.to_s
end

def validate_guess(guess)
  valid = "no"
  while valid == "no"
    if /[A-Za-z]/ === guess
      valid = "yes"
    else
      puts "Please enter a valid letter: "
      guess = gets.chomp
    end
  end
  guess
end

def user_turn(game_word)
  puts "Please guess a letter: "
  guess = gets.chomp.downcase
  validated_guess = validate_guess(guess)

end

def main
  mode_selected = get_user_mode
  word_list = stage_words(mode_selected)
  game_word = word_list.sample
  begin_game(game_word)
  user_turn(game_word)

end

if __FILE__ == $PROGRAM_NAME
  main
end
