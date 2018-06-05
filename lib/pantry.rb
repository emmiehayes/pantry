require 'pry'
class Pantry
  attr_reader :stock, :shopping_list, :cookbook

  def initialize
    @stock = {}
    @shopping_list = {}
    @cookbook = []
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

  def print_shopping_list
    @shopping_list.map do |ingredient, quantity|
      p "* #{ingredient}: #{quantity}\n"
    end
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def what_can_i_make
    
  end


end
