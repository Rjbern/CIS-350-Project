import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;

  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final Map<String, Map<String, String>> meals = {
    'Monday': {'Meals': ''},
    'Tuesday': {'Meals': ''},
    'Wednesday': {'Meals': ''},
    'Thursday': {'Meals': ''},
    'Friday': {'Meals': ''},
    'Saturday': {'Meals': ''},
    'Sunday': {'Meals': ''},
  };

  void _addFoodItem(String day, String meal) {
    TextEditingController foodController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add food for $meal on $day'),
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
                  meals[day]![meal] = foodController.text;
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

  void _deleteFoodItem(String day, String meal) {
    TextEditingController foodController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete food for $meal on $day'),
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
                  meals[day]![meal] = foodController.text;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Center(
          child: Text(
            "Dinner Planner",
            style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Planner"),
          NavigationDestination(icon: Icon(Icons.book), label: "Recipies"),
          NavigationDestination(
              icon: Icon(Icons.local_grocery_store_rounded),
              label: "Groceries"),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: DateTime.now(),
            calendarFormat: CalendarFormat.week,
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
                            "Meal",
                            style: TextStyle(fontSize: 14.0),
                          ),
                          trailing: Text(meals[day]!['Meal'] ?? ''),
                          onTap: () => _addFoodItem(day, 'Meal'),
                        ),
                        ElevatedButton(
                          onPressed: () => _addFoodItem(day, 'Meal'),
                          child: const Text('Add Food'),
                        ),
                        ElevatedButton(
                          onPressed: () => _deleteFoodItem(day, 'Meal'),
                          child: const Text('Delete Food'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
