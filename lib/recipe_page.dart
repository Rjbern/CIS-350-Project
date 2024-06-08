import 'package:flutter/material.dart';
import 'package:project_testing1/recipe_adapter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_testing1/globals.dart';

const int recipeCount = 1;

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  RecipePageState createState() => RecipePageState();
}

class RecipePageState extends State<RecipePage> {
  late Box<Recipe> recipeBox;


  // add listerner to hive box.
  // When chnages setState() is called allowing for refresh right away
  // Not only when recipe page is recalled
  @override
  void initState() {
    super.initState();
    recipeBox = Hive.box<Recipe>(recipeStorageName);
    recipeBox.listenable().addListener(() {
      setState(() {});
    });
  }

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
          _openRecipeCreation(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _openRecipeCreation(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController preptimeController = TextEditingController();
    TextEditingController cooktimeController = TextEditingController();
    TextEditingController ingredientsController = TextEditingController();
    TextEditingController intructionsController = TextEditingController();

    bool allParamsEntered(
        String name, int prep, cook, List<String> ing, String ins) {
      if ((name.isEmpty) || (ins.isEmpty)) {
        throw Exception('Name or instruction not entered');
      } else if ((prep < 0) || (cook < 0)) {
        throw Exception('preptime or cooktime under 0');
      } else if (ing.isEmpty) {
        throw Exception('No ingredients entered');
      }

      return true;
    }

    void errorMessage(BuildContext context, Object exceptionThrown) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text(exceptionThrown.toString()), actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close')),
          ]);
        },
      );
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Enter Recipe:'),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: "Name"),
              ),
              TextField(
                controller: preptimeController,
                decoration:
                    const InputDecoration(hintText: "Preptime in minutes"),
              ),
              TextField(
                controller: cooktimeController,
                decoration:
                    const InputDecoration(hintText: "Cooktime in minutes"),
              ),
              TextField(
                controller: ingredientsController,
                decoration: const InputDecoration(
                    hintText: "Ingredients seperated by commas"),
              ),
              TextField(
                controller: intructionsController,
                decoration: const InputDecoration(hintText: "Intructions"),
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
                  try {
                    String newName = nameController.text;
                    int newPrepTime = int.parse(preptimeController.text);
                    int newCookTime = int.parse(cooktimeController.text);
                    List<String> newIngredients =
                        ingredientsController.text.split(',');
                    String newIntructions = intructionsController.text;

                    // Add to recipe list
                    if (allParamsEntered(newName, newPrepTime, newCookTime,
                        newIngredients, newIntructions)) {
                      //Need to put recipe into box
                      final box = Hive.box<Recipe>(recipeStorageName);
                      box.add(Recipe(newName, newPrepTime, newCookTime,
                          newIngredients, newIntructions));

                      // Close
                      Navigator.of(context).pop();
                    }
                  } catch (ex) {
                    errorMessage(context, ex);
                  }
                },
                child: const Text('Add'),
              )
            ],
          );
        });
  }
}
