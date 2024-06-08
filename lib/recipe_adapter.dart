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

class RecipeBuilder extends StatefulWidget {
  RecipeBuilder({super.key});

  @override
  _RecipeBuilderState createState() => _RecipeBuilderState();
}

class _RecipeBuilderState extends State<RecipeBuilder> {
  final recipeBox = Hive.box<Recipe>(recipeStorageName);

  void _deleteRecipe(int index) {
    recipeBox.deleteAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Recipe currentRecipe;
    return ListView.builder(
      itemCount: recipeBox.length,
      itemBuilder: (BuildContext context, int index) {
        currentRecipe = recipeBox.getAt(index)!;
        return ExpansionTile(
          title: Text('Recipe ${(index + 1)}: ${currentRecipe.name}'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Prep Time: ${currentRecipe.prepTime} minutes',
                      style: const TextStyle(fontSize: 18)),
                  Text('Cook Time: ${currentRecipe.cookTime} minutes',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  const Text('Ingredients:',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  for (var ingredient in currentRecipe.ingredients)
                    Text('- $ingredient', style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 20),
                  const Text('Instructions:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(currentRecipe.instructions,
                      style: const TextStyle(fontSize: 12))
                ],
              ),
            ),
            // Delete Recipe Button
            TextButton(
              onPressed: () {
                _deleteRecipe(index);
              },
              child: const Text('Delete Recipe'),
            ),
          ],
        );
      },
    );
  }
}
