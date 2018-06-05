require 'pry'
class Pantry
  attr_reader :stock
  attr_accessor :shopping_list

  def initialize
    @stock = {}
    @shopping_list = {}
  end

  def stock_check(item)
    @stock[item]
  end

  def restock(item, qty)
    if @stock.keys.include?(item)
      @stock[item] += qty
    else
      @stock[item] = qty
    end
    @stock
  end

  def add_to_shopping_list(recipe)
    @shopping_list.merge!(recipe.ingredients)
  end


end
