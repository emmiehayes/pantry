require 'pry'
class Pantry
  attr_reader :stock

  def initialize
    @stock = {}
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
end
