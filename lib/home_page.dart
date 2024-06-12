import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_testing1/globals.dart';
import 'package:project_testing1/recipe_adapter.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

// Creats days of the week.
class _HomePage extends State<HomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  late Box<Recipe> recipeBox, mealBox;

  final List<String> daysOfWeek = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  // Sets the array for collecting the meals added.
  final Map<String, Map<String, List<String>>> meals = {
    'Sunday': {'Meals': []},
    'Monday': {'Meals': []},
    'Tuesday': {'Meals': []},
    'Wednesday': {'Meals': []},
    'Thursday': {'Meals': []},
    'Friday': {'Meals': []},
    'Saturday': {'Meals': []},
  };

  // add listerner to hive box.
  // When chnages setState() is called allowing for refresh right away
  // Not only when recipe page is recalled
  @override
  void initState() {
    super.initState();
    mealBox = Hive.box<Recipe>(plannedMealStorageName);
    recipeBox = Hive.box<Recipe>(recipeStorageName);
    mealBox.listenable().addListener(() {
      setState(() {});
    });
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

  // Add food item depending on what day you have selected
  void _addFoodItem(int weekDay) {
    TextEditingController foodController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add a meal on ${_getDateOfWeekday(weekDay)}'),
          content: TextField(
            controller: foodController,
            decoration: const InputDecoration(hintText: "Enter Recipe Number"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  // 1 Indexed in view so minus 1 from their number to get 0 indexed
                  int index = int.parse(foodController.text) - 1;
                  Recipe newRecipe = recipeBox.getAt(index)!;
                  Recipe newInstance = Recipe(newRecipe.name, newRecipe.prepTime,
                    newRecipe.cookTime, newRecipe.ingredients, newRecipe.instructions);

                  await mealBox.put(_getDateOfWeekday(weekDay), newInstance);
                  Navigator.of(context).pop();
                } catch (ex) {
                  errorMessage(context, "Make sure to only input the recipe number");
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // deletes food from the day selected if it is there
  void _deleteFoodItem(int weekDay) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure you want to delete the meal on ${_getDateOfWeekday(weekDay)}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await mealBox.delete(_getDateOfWeekday(weekDay));
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  String _getDateOfWeekday(int weekDay) {
    /// Finds the date of the weekday based on the week range of [_focusedDay]
    ///
    /// [weekDay] is an index 0-6 resembling day of the week starting at sun (0) and going to sat (6)
    var targetDate = _focusedDay
        .subtract(Duration(days: _focusedDay.weekday))
        .add(Duration(days: weekDay));
    return '${targetDate.month}/${targetDate.day}/${targetDate.year}';
  }

  Widget? _showRecipe(Recipe? currentRecipe) {
    if (currentRecipe == null) {
      return null;
    }
    return ExpansionTile(
      title: Text(currentRecipe.name),
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2024, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          onFormatChanged: (format) {
            _calendarFormat = CalendarFormat.week;
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
            setState(() {});
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: ListView.builder(
              itemCount: daysOfWeek.length,
              itemBuilder: (context, index) {
                String day = daysOfWeek[index];
                Recipe? currRecipe;
                try {
                  currRecipe = mealBox.get(_getDateOfWeekday(index));
                } catch(er) {
                  currRecipe = null;
                  print(er.toString());
                }
                
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Center(
                          child: Text(
                            "$day : ${_getDateOfWeekday(index)}",
                            style: const TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
                      _showRecipe(currRecipe) ?? const Text(""),
                      // creates the button that can add meal and assign method add.
                      Center(
                        child : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _addFoodItem(index);
                                  setState(() {});
                                },
                                child: const Text('Add Meal'),
                              ),
                              const Spacer(),
                              // Creates button that can delete food and assigns the method delete.
                              ElevatedButton(
                                onPressed: () {
                                  _deleteFoodItem(index);
                                  setState(() {});
                                },
                                child: const Text('Delete Meal'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
