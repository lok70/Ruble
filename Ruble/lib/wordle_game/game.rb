module WordleGame
    class Game
      attr_reader :word_length, :max_attempts, :attempts, :target_word
  
      WORD_LIST = %w[apple banjo cider delta eagle other words]
  
      def initialize(word_length = 5, max_attempts = 6)
        @word_length = word_length
        @max_attempts = max_attempts
        @attempts = []
        @target_word = WORD_LIST.select { |word| word.length == word_length }.sample
      end
  
      def attempt(guess)
        return { status: :game_over, message: "No more attempts allowed" } if game_over?
  
        if guess.length != word_length
          return { status: :invalid, message: "Guess length must be #{word_length}" }
        end
  
        result = check_guess(guess)
        attempts << { guess: guess, result: result }
  
        if guess == target_word
          { status: :correct, result: result, attempts_left: max_attempts - attempts.size }
        elsif attempts.size >= max_attempts
          { status: :game_over, result: result, attempts_left: 0 }
        else
          { status: :incorrect, result: result, attempts_left: max_attempts - attempts.size }
        end
      end
  
      private
  
      def game_over?
        attempts.size >= max_attempts || attempts.any? { |a| a[:guess] == target_word }
      end
  
      def check_guess(guess)
        guess.chars.map.with_index do |char, index|
          if char == target_word[index]
            :green
          elsif target_word.include?(char)
            :yellow
          else
            :grey
          end
        end
      end
    end
  end