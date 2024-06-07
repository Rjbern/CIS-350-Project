// This creats new page to submit new recipe
// Adds text feilds for all parts of recipe
// Takes and submits them to the list 
// Creats button
import 'package:flutter/material.dart';
import 'package:project_testing1/recipe_storage_map.dart';

void _openRecipeCreation(String name, String preptime, String cooktime,
    String ingredients, String intructions) {
  TextEditingController nameController = TextEditingController();
  TextEditingController preptimeController = TextEditingController();
  TextEditingController cooktimeController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController intructionsController = TextEditingController();

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Recipe:'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: "Enter name"),
            ),
            TextField(
              controller: preptimeController,
              decoration: const InputDecoration(hintText: "Enter preptime"),
            ),
            TextField(
              controller: cooktimeController,
              decoration: const InputDecoration(hintText: "Enter cooktime"),
            ),
            TextField(
              controller: ingredientsController,
              decoration: const InputDecoration(hintText: "Enter ingredients"),
            ),
            TextField(
              controller: intructionsController,
              decoration: const InputDecoration(hintText: "Enter intructions"),
            ),
          ]),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle sumbitted data
                String newName = nameController.text;
                String newPrepTime = preptimeController.text;
                String newCookTime = cooktimeController.text;
                String newIngredients = ingredientsController.text;
                String newIntructions = intructionsController.text;

                // Add to recipe list
                recipes['Recipies']?.add({
                  'Name': newName,
                  'PrepTime': newPrepTime,
                  'CookTime': newCookTime,
                  'Ingredients': newIngredients,
                  'Intructions': newIntructions,
                });
                // Close
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            )
          ],
        );
      });
}
