import 'package:flutter/material.dart';
import 'package:project_testing1/recipe_adapter.dart';
import 'package:project_testing1/globals.dart';

class GroceriesPage extends StatefulWidget {
  const GroceriesPage({super.key});

  @override
  _GroceriesPageState createState() => _GroceriesPageState();
}

class _GroceriesPageState extends State<GroceriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List:'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ingredients:',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            if (plannedIngredientsName.isEmpty)
              const Text('No ingredients planned',
                  style: TextStyle(fontSize: 12)),
            for (var i in plannedIngredientsName)
              Text('- $i', style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
