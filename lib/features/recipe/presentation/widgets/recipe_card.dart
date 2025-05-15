import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/features/recipe/domain/entities/recipe_entity.dart';

class RecipeCard extends StatelessWidget {
  final RecipeEntity recipe;
  final VoidCallback? onTap;

  const RecipeCard({
    super.key,
    required this.recipe,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            (kIsWeb)
                ? const SizedBox.shrink()
                : ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      recipe.image,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, _) => const SizedBox(
                          height: 100,
                          child:
                              Center(child: Icon(Icons.image_not_supported))),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    recipe.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  // Used Ingredients
                  if (recipe.usedIngredients.isNotEmpty) ...[
                    Text(
                      "Used Ingredients:",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      recipe.usedIngredients.map((e) => e.name).join(', '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                  ],

                  // Missed Ingredients
                  if (recipe.missedIngredients.isNotEmpty) ...[
                    Text(
                      "Missing Ingredients:",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      recipe.missedIngredients.map((e) => e.name).join(', '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.redAccent),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
