// recipe.dart
import 'package:flutter/material.dart';

class Recipe extends StatelessWidget {
  const Recipe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boba Recipes'),
      ),
      body: const Center(
        child: Text('Recipe'),
      ),
    );
  }
}
