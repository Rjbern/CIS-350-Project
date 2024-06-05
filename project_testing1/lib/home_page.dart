import 'package:flutter/material.dart';
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

  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  // Sets the array for collecting the meals added.
  final Map<String, Map<String, List<String>>> meals = {
    'Monday': {'Meals': []},
    'Tuesday': {'Meals': []},
    'Wednesday': {'Meals': []},
    'Thursday': {'Meals': []},
    'Friday': {'Meals': []},
    'Saturday': {'Meals': []},
    'Sunday': {'Meals': []},
  };

  // Add food item depending on what day you have selected
  void _addFoodItem(String day, String meal) {
    TextEditingController foodController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add a meal on $day'),
          content: TextField(
            controller: foodController,
            decoration: const InputDecoration(hintText: "Enter food item"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // adds the entered food item to the list of meals for the specified day and meal in the meals map.
                  meals[day]![meal]!.add(foodController.text);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // deletes food from the day selected if it is there
  void _deleteFoodItem(String day, String meal) {
    TextEditingController foodController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete meal on $day'),
          content: TextField(
            controller: foodController,
            decoration: const InputDecoration(hintText: "Enter food item"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  meals[day]![meal]!.remove(foodController.text);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  String _getCurrentWeekRange(DateTime date) {
    final firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));
    final lastDayOfWeek = date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
    return '${firstDayOfWeek.toLocal().year}:${firstDayOfWeek.toLocal().month}:${firstDayOfWeek.toLocal().day} - ${lastDayOfWeek.toLocal().year}:${lastDayOfWeek.toLocal().month}:${lastDayOfWeek.toLocal().day}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2024, 1, 1),
          lastDay: DateTime.utc(2024, 12, 31),
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
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ExpansionTile(
                    title: Text(
                      day,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    children: [
                      ListTile(
                        title: const Text(
                          "Meals:",
                          style: TextStyle(fontSize: 14.0),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: meals[day]!['Meals']!
                              .map((foodItem) => Text(foodItem))
                              .toList(),
                        ),
                      ),
                      // creates the button that can add meal and assign method add.
                      ElevatedButton(
                        onPressed: () => _addFoodItem(day, 'Meals'),
                        child: const Text('Add Food'),
                      ),
                      // Creates button that can delete food and assigns the method delete.
                      ElevatedButton(
                        onPressed: () => _deleteFoodItem(day, 'Meals'),
                        child: const Text('Delete Food'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        Text(
        'Current Week: ${_getCurrentWeekRange(_focusedDay)}',
        style: const TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}
