class Recipe
  attr_reader :name, :ingredients

  def initialize(name)
    @name = name
    @ingredients = {}
  end

  def ingredient_types
    @ingredients.keys
  end

  def add_ingredient(ingredient_name, amount)
    if @ingredients.keys.include?(ingredient_name)
      @ingredients[ingredient_name] += amount
    else
    @ingredients[ingredient_name] = amount
    end
  end

  def amount_required(ingredient_name)
    @ingredients[ingredient_name]
  end
end
