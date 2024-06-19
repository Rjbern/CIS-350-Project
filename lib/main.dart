import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_testing1/groceries_page.dart';
import 'package:project_testing1/home_page.dart';
import 'package:project_testing1/recipe_adapter.dart';
import 'package:project_testing1/recipe_page.dart';
import 'package:project_testing1/globals.dart';

void main() async {
  // init storage
  await Hive.initFlutter();
  Hive.registerAdapter(RecipeAdapter());

  // Open Boxs.
  await Hive.openBox<Recipe>(recipeStorageName);
  await Hive.openBox<Recipe>(plannedMealStorageName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  DateTime focusedDay = DateTime.now();
  List<Widget> pages = const [
    HomePage(),
    RecipePage(),
    GroceriesPage(),
  ];

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
        body: pages[currentPage]);
  }
}
