require 'minitest/autorun'
require 'minitest/pride'
require './lib/pantry'
require './lib/recipe'

class PantryTest < Minitest::Test

  def test_it_has_attributes
    pantry = Pantry.new

    assert_equal ({}), pantry.stock
  end

  def test_it_can_check_stock
    pantry = Pantry.new

    assert pantry.stock.empty?
  end

  def test_it_can_add_items_to_stock
    pantry = Pantry.new
    pantry.restock('Cheese', 10)

    assert_equal ({'Cheese' => 10}), pantry.stock
  end

  def test_it_can_add_to_current_stock_level
    pantry = Pantry.new
    pantry.restock('Cheese', 10)
    pantry.restock('Cheese', 20)

    assert_equal ({'Cheese' => 30}), pantry.stock
  end

  def test_it_has_a_shopping_list_that_can_be_added_to
    pantry = Pantry.new
    recipe = Recipe.new('Cheese Pizza')
    recipe.add_ingredient('Cheese', 20)
    recipe.add_ingredient('Flour', 20)
    pantry.add_to_shopping_list(recipe)
    result = {'Cheese' => 20, 'Flour' => 20}

    assert_equal result, recipe.ingredients
    assert_equal result, pantry.shopping_list
  end

  def test_it_can_add_another_recipe
    pantry = Pantry.new
    recipe = Recipe.new('Spaghetti')
    recipe.add_ingredient('Cheese', 20)
    recipe.add_ingredient('Flour', 20)
    recipe.add_ingredient('Spaghetti Noodles', 10)
    recipe.add_ingredient('Marinara Sauce', 10)
    recipe.add_ingredient('Cheese', 5)
    pantry.add_to_shopping_list(recipe)
    expected = { 'Cheese' => 25,
                 'Flour' => 20,
                 'Spaghetti Noodles' => 10,
                 'Marinara Sauce' => 10
                }

    assert_equal expected, pantry.shopping_list
  end

end
