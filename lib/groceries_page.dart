import 'package:flutter/material.dart';
import 'package:project_testing1/globals.dart';

class GroceriesPage extends StatefulWidget {
  const GroceriesPage({super.key});

  @override
  GroceriesPageState createState() => GroceriesPageState();
}

class GroceriesPageState extends State<GroceriesPage> {
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
            if (plannedIngredients.isEmpty)
              const Text('No ingredients planned',
                  style: TextStyle(fontSize: 12)),
            /// Looks through ingrediants in all planned meals.
            for (var i in plannedIngredients)
              Text('- $i', style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
