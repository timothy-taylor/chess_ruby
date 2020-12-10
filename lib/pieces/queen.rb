# frozen_string_literal: true

require_relative '../movement'
require_relative '../board'
require_relative '../chess_set'

class Queen
  attr_reader :symbol, :id, :move_tree
  attr_accessor :current_pos

  def initialize(id, parent, symbol, position)
    @id = id
    @gameboard = parent
    @symbol = symbol
    @current_pos = position
    @move_tree = Tree.new(position)
  end

  def available_moves(position = @current_pos)
    x = position[0]
    y = position[1]
    allowable = []
    possible_moves = []
    7.times do |n|
      possible_moves << [x + (n + 1), y]
      possible_moves << [x, y + (n + 1)]
      possible_moves << [x + (n + 1), y + (n + 1)]
      possible_moves << [x - (n + 1), y - (n + 1)]
    end
    possible_moves.each do |e|
      allowable << e if @gameboard.allowable_move?(e, self)
    end
    allowable
  end

  def moves(dest)
    @move_tree.populate_and_return(self, dest)
  end
end
