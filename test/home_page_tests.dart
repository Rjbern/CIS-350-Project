import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_testing1/globals.dart';
import 'package:project_testing1/home_page.dart';
import 'package:project_testing1/recipe_adapter.dart';

Box<Recipe>? mealBox;

void main() {
  hiveInit();

  test('Getting Day of the Week', () {
    final home = HomePageState();

    // Test Getting Sunday of this week
    String day = home.getDateOfWeekday(0);
    var expectedDate = DateTime.now().subtract(Duration(days: DateTime.now().weekday));
    String expectedDay = "${expectedDate.month}/${expectedDate.day}/${expectedDate.year}";
    expect(day, expectedDay);

    // Testing Getting Saturday of this week
    day = home.getDateOfWeekday(6);
    expectedDate = DateTime.now().add(Duration(days: DateTime.daysPerWeek - DateTime.now().weekday - 1));
    expectedDay = "${expectedDate.month}/${expectedDate.day}/${expectedDate.year}";
    expect(day, expectedDay);
  }); 
}

Future<void> hiveInit() async {
  Hive.init('./test/tempHive');
  Hive.registerAdapter(RecipeAdapter());

  await Hive.openBox<Recipe>(recipeStorageName);
  mealBox = await Hive.openBox<Recipe>(plannedMealStorageName);
}
