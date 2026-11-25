class RecipeIngredient {
  const RecipeIngredient({
    required this.amount,
    required this.name,
    this.section = 'Ingredients',
  });

  final String amount;
  final String name;
  final String section;
}

class RecipeStep {
  const RecipeStep({required this.number, required this.text, this.minutes});

  final int number;
  final String text;
  final int? minutes;
}

class Recipe {
  const Recipe({
    required this.id,
    required this.title,
    required this.author,
    required this.blurb,
    required this.image,
    required this.yieldText,
    required this.timeText,
    required this.minutes,
    required this.categories,
    required this.ingredients,
    required this.steps,
    this.collection,
    this.featured = false,
  });

  final String id;
  final String title;
  final String author;
  final String blurb;
  final String image;
  final String yieldText;
  final String timeText;
  final int minutes;
  final List<String> categories;
  final List<RecipeIngredient> ingredients;
  final List<RecipeStep> steps;
  final String? collection;
  final bool featured;
}

class RecipeCollection {
  const RecipeCollection({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.recipeIds,
    required this.tint,
  });

  final String id;
  final String title;
  final String subtitle;
  final List<String> recipeIds;
  final int tint; // 0 sage, 1 peach, 2 butter
}
