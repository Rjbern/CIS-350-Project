// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:project_testing1/globals.dart';
import 'package:project_testing1/home_page.dart';

import 'package:project_testing1/main.dart';
import 'package:project_testing1/recipe_adapter.dart';
import 'package:table_calendar/table_calendar.dart';

void main() async {
  await hiveInit();

  testWidgets('Finding HomePage Widgets', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the page starts up in the right state
    expect(find.text('Get Current Weeks Groceries'), findsOneWidget);
    expect(find.byType(TableCalendar), findsOneWidget);
    expect(find.text('Add Meal'), findsAny);
    expect(find.text('Delete Meal'), findsAny);
    expect(find.textContaining('Sunday'), findsOneWidget);
  });

  testWidgets('Recipe Page Trial', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    const app = MyApp();
    await tester.pumpWidget(app);

    //Make sure the recipe page shows up right
    var findNavigation = find.byType(NavigationDestination);
    expect(findNavigation, findsExactly(3));

    await tester.tap(findNavigation.at(1));
    await tester.pump();

    // Confirms that it is on the new page 
    expect(find.text('Recipies'), findsExactly(2));

    // Pull up recipe creation
    var findCreateButton = find.byType(FloatingActionButton);
    await tester.tap(findCreateButton);
    await tester.pump();

    // Confirms that the creation box popped up
    expect(find.text('Enter Recipe:'), findsOneWidget);
  });

  test('Getting Day of the Week Unit Test', () {
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
  await Hive.openBox<Recipe>(plannedMealStorageName);
}
