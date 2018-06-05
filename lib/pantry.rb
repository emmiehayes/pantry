require 'pry'
class Pantry
  attr_reader :stock, :shopping_list, :cookbook

  def initialize
    @stock = {}
    @shopping_list = {}
    @cookbook = []
    @batches = []
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

  def has_all_ingredients?(recipe)
    recipe.ingredients.map do |item, qty|
      if @stock.keys.include?(item) && @stock[item] >= qty
        true
      else
        return false
      end
    end
  end

  def what_can_i_make
    @cookbook.map do |recipe|
      recipe.name if has_all_ingredients?(recipe)
    end.compact
  end

  def calculate_batches(recipe)
    recipe.ingredients.map do |item, qty|
      @stock.include?(item) && has_all_ingredients?(recipe)
      return recipe.name, (@stock[item] / qty).abs
    end.uniq
  end

  def how_many_can_i_make
    what_can_i_make.map do |recipe_name|
      @cookbook.map do |recipe|
        if recipe.name == recipe_name
          @batches << calculate_batches(recipe)
        end
        @batches
      end
    end
  end
end
