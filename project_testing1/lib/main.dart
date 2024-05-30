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
    'Monday': {'Breakfast': 'Eggs', 'Lunch': 'Sandwich', 'Dinner': 'Pizza'},
    'Tuesday': {'Breakfast': 'Eggs', 'Lunch': 'Sandwich', 'Dinner': 'Pizza'},
    'Wednesday': {'Breakfast': 'Eggs', 'Lunch': 'Sandwich', 'Dinner': 'Pizza'},
    'Thursday': {'Breakfast': 'Eggs', 'Lunch': 'Sandwich', 'Dinner': 'Pizza'},
    'Friday': {'Breakfast': 'Eggs', 'Lunch': 'Sandwich', 'Dinner': 'Pizza'},
    'Saturday': {'Breakfast': 'Eggs', 'Lunch': 'Sandwich', 'Dinner': 'Pizza'},
    'Sunday': {'Breakfast': 'Eggs', 'Lunch': 'Sandwich', 'Dinner': 'Pizza'},
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
            decoration: InputDecoration(hintText: "Enter food item"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  meals[day]![meal] = foodController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
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
                          style: TextStyle(fontSize: 18.0),
                        ),
                        children: [
                          ListTile(
                            title: Text(
                              "Breakfast",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            trailing: Text(meals[day]!['Breakfast'] ?? ''),
                            onTap: () => _addFoodItem(day, 'Breakfast'),
                          ),
                          ListTile(
                            title: Text(
                              "Lunch",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            trailing: Text(meals[day]!['Lunch'] ?? ''),
                            onTap: () => _addFoodItem(day, 'Lunch'),
                          ),
                          ListTile(
                            title: Text(
                              "Dinner",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            trailing: Text(meals[day]!['Dinner'] ?? ''),
                            onTap: () => _addFoodItem(day, 'Dinner'),
                          ),
                          ElevatedButton(
                            onPressed: () => _addFoodItem(day, 'Dinner'),
                            child: Text('Add Food'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ));
  }
}
