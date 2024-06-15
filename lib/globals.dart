import 'package:project_testing1/recipe_adapter.dart';

//Define Global Variables here
String recipeStorageName = 'recipeStorage';
String plannedMealStorageName = 'plannedMealsStorage';
List<String> plannedIngredients = [];

Recipe starterRecipe = Recipe(
    'Spaghetti Carbonara',
    15,
    20,
    ['Spaghetti', 'Eggs', 'Pancetta', 'Parmesan Cheese', 'Black Pepper'],
    '1. Boil spaghetti. 2. Cook pancetta. 3. Mix eggs and cheese. 4. Combine all.');

Recipe testerRecipe = Recipe(
    "Tacos",
    5,
    15,
    ['Burger', 'Taco Seasoning', 'Milk'],
    'Brown buger, simmer with taco seasoning and milk. Serve as enjoyed.');