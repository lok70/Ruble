require "spec_helper"

RSpec.describe WordleGame::Game do
  let(:game) { WordleGame::Game.new(5, 6) }

  describe '#initialize' do
    it 'sets the word length' do
      expect(game.word_length).to eq(5)
    end

    it 'sets the max attempts' do
      expect(game.max_attempts).to eq(6)
    end

    it 'chooses a target word from the word list' do
      expect(WordleGame::Game::WORD_LIST).to include(game.target_word)
    end

    context 'with custom parameters' do
      let(:custom_game) { WordleGame::Game.new(7, 10) }

      it 'sets the custom word length' do
        expect(custom_game.word_length).to eq(7)
      end

      it 'sets the custom max attempts' do
        expect(custom_game.max_attempts).to eq(10)
      end

      it 'chooses a target word with the custom word length' do
        expect(custom_game.target_word.length).to eq(7)
      end
    end
  end

  describe '#attempt' do
    context 'when the guess length is incorrect' do
      it 'returns an invalid status' do
        result = game.attempt('shor')
        expect(result[:status]).to eq(:invalid)
        expect(result[:message]).to eq("Guess length must be 5")
      end

      it 'returns an invalid status for a too long guess' do
        result = game.attempt('toolong')
        expect(result[:status]).to eq(:invalid)
        expect(result[:message]).to eq("Guess length must be 5")
      end
    end

    context 'when the guess is correct' do
      it 'returns a correct status and green result' do
        game.instance_variable_set(:@target_word, 'apple')
        result = game.attempt('apple')
        expect(result[:status]).to eq(:correct)
        expect(result[:result]).to eq([:green, :green, :green, :green, :green])
      end
    end

    context 'when the guess is incorrect' do
      it 'returns an incorrect status and the correct result array' do
        game.instance_variable_set(:@target_word, 'apple')
        result = game.attempt('apply')
        expect(result[:status]).to eq(:incorrect)
        expect(result[:result]).to eq([:green, :green, :green, :green, :grey])
        expect(result[:attempts_left]).to eq(5)
      end

      it 'handles partially correct guesses' do
        game.instance_variable_set(:@target_word, 'apple')
        result = game.attempt('pearl')
        expect(result[:status]).to eq(:incorrect)
        expect(result[:result]).to eq([:yellow, :yellow, :yellow, :grey, :yellow])
        expect(result[:attempts_left]).to eq(5)
      end
    end

    context 'when the game is over' do
      it 'returns game over status if no attempts are left' do
        game.instance_variable_set(:@attempts, Array.new(6) { { guess: 'wrong', result: [:grey, :grey, :grey, :grey, :grey] } })
        result = game.attempt('apple')
        expect(result[:status]).to eq(:game_over)
        expect(result[:message]).to eq("No more attempts allowed")
      end

      it 'returns game over status if the correct word was guessed' do
        game.instance_variable_set(:@target_word, 'apple')
        game.instance_variable_set(:@attempts, [{ guess: 'apple', result: [:green, :green, :green, :green, :green] }])
        result = game.attempt('apple')
        expect(result[:status]).to eq(:game_over)
        expect(result[:message]).to eq("No more attempts allowed")
      end
    end

    context 'when guess contains spaces' do
      it 'returns an invalid status' do
        result = game.attempt('     ')
        expect(result[:status]).to eq(:invalid)
        expect(result[:message]).to eq("Guess length must be 5")
      end
    end

    context 'when guess is empty' do
      it 'returns an invalid status' do
        result = game.attempt('')
        expect(result[:status]).to eq(:invalid)
        expect(result[:message]).to eq("Guess length must be 5")
      end
    end
  end

  describe '#check_guess' do
    it 'returns the correct result array' do
      game.instance_variable_set(:@target_word, 'apple')
      result = game.send(:check_guess, 'apply')
      expect(result).to eq([:green, :green, :green, :green, :grey])

      result = game.send(:check_guess, 'pearl')
      expect(result).to eq([:yellow, :yellow, :yellow, :grey, :yellow])
    end

    it 'handles guesses with repeated letters correctly' do
      game.instance_variable_set(:@target_word, 'apple')
      result = game.send(:check_guess, 'allee')
      expect(result).to eq([:green, :yellow, :grey, :grey, :green])
    end
  end
end
