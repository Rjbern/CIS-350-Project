import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:project_testing1/globals.dart';

part 'recipe_adapter.g.dart';

@HiveType(typeId: 0)
class Recipe extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int prepTime; // in minutes

  @HiveField(2)
  int cookTime; // in minutes

  @HiveField(3)
  List<String> ingredients;
  
  @HiveField(4)
  String instructions;

  Recipe(this.name, this.prepTime, this.cookTime, this.ingredients,
      this.instructions);
}

const int recipeCount = 1;

class RecipeBuilder extends StatelessWidget {
  const RecipeBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final Recipe recipe = starterRecipe;

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
                    Text('- $ingredient', style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 20),
                  const Text('Instructions:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(recipe.instructions, style: const TextStyle(fontSize: 12))
                ],
              ),
            )
          ],
        );
      },
    );
  }
}