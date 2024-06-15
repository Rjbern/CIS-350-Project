// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:project_testing1/globals.dart';

import 'package:project_testing1/main.dart';
import 'package:project_testing1/recipe_adapter.dart';
import 'package:table_calendar/table_calendar.dart';

void main() async {
  await hiveInit();

  testWidgets('Finding HomePage Widgets', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('Get Current Weeks Groceries'), findsOneWidget);
    expect(find.byType(TableCalendar), findsOneWidget);
  });
}

Future<void> hiveInit() async {
  Hive.init('./test/tempHive');
  Hive.registerAdapter(RecipeAdapter());

  await Hive.openBox<Recipe>(recipeStorageName);
  await Hive.openBox<Recipe>(plannedMealStorageName);
}
