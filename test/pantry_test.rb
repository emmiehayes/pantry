require 'minitest/autorun'
require 'minitest/pride'
require './lib/pantry'
require './lib/recipe'

class PantryTest < Minitest::Test

  def test_it_has_attributes
    p = Pantry.new
    assert_equal ({}), p.stock
  end

  def test_it_can_check_stock
    p = Pantry.new
    assert p.stock.empty?
  end

  def test_it_can_add_items_to_stock
    p = Pantry.new
    p.restock('Cheese', 10)
    assert_equal ({'Cheese' => 10}), p.stock
  end

  def test_it_can_add_to_current_stock_level
    p = Pantry.new
    p.restock('Cheese', 10)
    p.restock('Cheese', 20)
    assert_equal ({'Cheese' => 30}), p.stock
  end

end
