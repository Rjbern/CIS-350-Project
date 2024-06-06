
// Unfinished
import 'package:flutter/material.dart';

void _openRecipeCreation(String name, String preptime, String cooktime,
    String ingredients, String intructions) {
  TextEditingController nameController = TextEditingController();
  TextEditingController preptimeController = TextEditingController();
  TextEditingController cooktimeController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController intructionsController = TextEditingController();

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text('Enter Recipe:'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "Enter name"),
            ),
            TextField(
              controller: preptimeController,
              decoration: InputDecoration(hintText: "Enter preptime"),
            ),
            TextField(
              controller: cooktimeController,
              decoration: InputDecoration(hintText: "Enter cooktime"),
            ),
            TextField(
              controller: ingredientsController,
              decoration: InputDecoration(hintText: "Enter ingredients"),
            ),
            TextField(
              controller: intructionsController,
              decoration: InputDecoration(hintText: "Enter intructions"),
            ),
              ],
            ),
            );
            
      });
}
