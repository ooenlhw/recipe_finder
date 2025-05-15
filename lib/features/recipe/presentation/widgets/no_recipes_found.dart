import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoRecipesFound extends StatelessWidget {
  const NoRecipesFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.warning, size: 48),
        SizedBox(height: 16),
        Text('No recipes found for this ingredient.'),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            context.pop();
          },
          child: Text('Try searching again'),
        ),
      ],
    );
  }
}
