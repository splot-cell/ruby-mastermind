# frozen_string_literal: true

require_relative "player"
require_relative "user_input"

class Codebreaker < Player
  def initialize(game, opponent)
    opponent.opponent = self
    super(game, opponent)
  end
end

class HumanCodebreaker < Codebreaker
  include UserInput
  def make_turn
    @game.board.push(user_selection)
    @game.guess += 1
    @opponent.make_turn
  end
end

class ComputerCodebreaker < Codebreaker
end