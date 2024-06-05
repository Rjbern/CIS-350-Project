import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const int recipeCount = 1;

class Recipe {
  String name;
  int prepTime; // in minutes
  int cookTime; // in minutes
  List<String> ingredients;
  String instructions;

  Recipe(this.name, this.prepTime, this.cookTime, this.ingredients,
      this.instructions);
}

class UserRecipeStorage {
  final List<Recipe> _recipeList = [];

  UserRecipeStorage(List<Recipe> recipes) {
    _recipeList.addAll(recipes);
  }

  Recipe getRecipe(int index) {
    return _recipeList[index];
  }

  void createRecipe(Recipe newRecipe) {
    _recipeList.add(newRecipe);
  }

  void deleteRecipe(int index) {
    _recipeList.removeAt(index);
  }
}

class RecipeBuilder extends StatelessWidget {
  const RecipeBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    Recipe recipe = Recipe('Spaghetti Carbonara', 15,20,[
        'Spaghetti',
        'Eggs',
        'Pancetta',
        'Parmesan Cheese',
        'Black Pepper'
      ],
          '1. Boil spaghetti. 2. Cook pancetta. 3. Mix eggs and cheese. 4. Combine all.'
    );

    return ListView.builder(
      itemCount: recipeCount,
      itemBuilder: (BuildContext context, int index) {
        return ExpansionTile(
          title: Text('Recipe ${(index + 1)}: ${recipe.name}'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Prep Time: ${recipe.prepTime} minutes',
                      style: const TextStyle(fontSize: 18)),
                  Text('Cook Time: ${recipe.cookTime} minutes',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  const Text('Ingredients:',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  for (var ingredient in recipe.ingredients)
                    Text('- $ingredient', style: TextStyle(fontSize: 12)),
                  const SizedBox(height: 20),
                  const Text('Instructions:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(recipe.instructions, style: TextStyle(fontSize: 12))
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
