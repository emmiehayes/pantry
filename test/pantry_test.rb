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

   def test_shopping_list_can_be_printed
     skip
    pantry = Pantry.new
    recipe = Recipe.new('Spaghetti')
    recipe.add_ingredient('Cheese', 20)
    recipe.add_ingredient('Flour', 20)
    recipe.add_ingredient('Spaghetti Noodles', 10)
    recipe.add_ingredient('Marinara Sauce', 10)
    recipe.add_ingredient('Cheese', 5)
    pantry.add_to_shopping_list(recipe)
    expected = "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"
    assert_equal expected, pantry.print_shopping_list
  end

  def test_it_can_build_a_recipe
    pantry = Pantry.new

    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    assert_equal 3, pantry.cookbook.count
    assert_instance_of Recipe, pantry.cookbook[0]

    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Cucumbers", 120)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)

    stock = {"Cheese"=>10,
             "Flour"=>20,
             "Brine"=>40,
             "Cucumbers"=>120,
             "Raw nuts"=>20,
             "Salt"=>20
            }
    assert_equal stock, pantry.stock

    refute pantry.has_all_ingredients?(r1)
    assert_equal ["Pickles", "Peanuts"], pantry.what_can_i_make

    assert_equal ["Peanuts", 2], pantry.calculate_batches(r3)
    assert_equal ["Pickles", 4], pantry.calculate_batches(r2)
    assert_equal ({"Pickles" => 4, "Peanuts" => 2}), pantry.how_many_can_i_make
  end
end
