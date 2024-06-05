import 'package:flutter/material.dart';
import 'package:project_testing1/recipe_template.dart';
import 'package:project_testing1/globals.dart';

class GroceriesPage extends StatelessWidget {
  const GroceriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Recipe recipe = starterRecipe;
    
    return Scaffold(
        appBar: AppBar(
          title: const Text('Grocery List:'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ 
                const Text('Ingredients:',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                for (var ingredient in recipe.ingredients)
                  Text('- $ingredient', style: const TextStyle(fontSize: 12)),
              ],
            )));
  }
}
