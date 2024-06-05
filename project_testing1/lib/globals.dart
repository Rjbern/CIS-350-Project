import 'package:project_testing1/recipe_adapter.dart';
import 'package:project_testing1/recipe_template.dart';

//Define Global Variables here
// UserRecipeStorage recipeStorage = UserRecipeStorage();

Recipe starterRecipe = Recipe('Spaghetti Carbonara', 15,20,
      [
        'Spaghetti',
        'Eggs',
        'Pancetta',
        'Parmesan Cheese',
        'Black Pepper'
      ],
      '1. Boil spaghetti. 2. Cook pancetta. 3. Mix eggs and cheese. 4. Combine all.'
    );

// Define Global Functions here
HiveRecipe convertToHiveRecipe(Recipe savingRecipe)
{
  return HiveRecipe(savingRecipe.name, savingRecipe.prepTime, savingRecipe.cookTime, savingRecipe.ingredients, savingRecipe.instructions);
}

Recipe convertToRecipe(HiveRecipe savingRecipe)
{
  return Recipe(savingRecipe.name, savingRecipe.prepTime, savingRecipe.cookTime, savingRecipe.ingredients, savingRecipe.instructions);
}