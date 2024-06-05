import 'package:flutter/material.dart';
import 'package:project_testing1/recipe_adapter.dart';

const int recipeCount = 1;

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recipies',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const RecipeBuilder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // final newRecipe = await openRecipeCreation(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  //TODO: Need to make it actually return a Recipe storage class
  Future<Recipe?> openRecipeCreation(context) => showDialog<Recipe>(
    context: context, 
    builder: (context) => AlertDialog(
      title: const Text('Create Recipe'),
      content: const TextField(decoration: InputDecoration(hintText: 'Name of Recipe')
      ),
      actions: [
        TextButton(
          onPressed: () {
            submit(context);
          },
          child: const Text('Submit'),
          ),
      ],
    ),
  );

  void submit(context) {
    Navigator.of(context).pop();
  }
}