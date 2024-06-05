import 'package:hive/hive.dart';

part 'recipe_adapter.g.dart';

@HiveType(typeId: 0)
class HiveRecipe extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int prepTime; // in minutes

  @HiveField(2)
  int cookTime; // in minutes

  @HiveField(3)
  List<String> ingredients;
  
  @HiveField(4)
  String instructions;

  HiveRecipe(this.name, this.prepTime, this.cookTime, this.ingredients,
      this.instructions);
}