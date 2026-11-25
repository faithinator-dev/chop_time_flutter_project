import '../assets/app_assets.dart';
import '../models/recipe.dart';

abstract final class RecipeCatalog {
  static const recipeOfTheDayId = 'squash-chickpeas';

  static final List<Recipe> all = [
    Recipe(
      id: 'squash-chickpeas',
      title: 'Roasted Squash With Turmeric-Ginger Chickpeas',
      author: 'Yewande Komolafe',
      blurb:
          'Custardy, mildly sweet roasted squash holds its own as a main course, brightened by turmeric-ginger chickpeas.',
      image: AppAssets.recipeSquash,
      yieldText: '4 servings',
      timeText: '45 minutes',
      minutes: 45,
      categories: const ['Dinner', 'Vegetarian', 'Healthy'],
      featured: true,
      collection: 'one-pot',
      ingredients: const [
        RecipeIngredient(
          amount: '1 medium',
          name: 'butternut squash, peeled and cubed',
          section: 'For the squash',
        ),
        RecipeIngredient(
          amount: '3 tablespoons',
          name: 'olive oil, divided',
          section: 'For the squash',
        ),
        RecipeIngredient(
          amount: '1 teaspoon',
          name: 'kosher salt',
          section: 'For the squash',
        ),
        RecipeIngredient(
          amount: '2 cans',
          name: 'chickpeas, drained and rinsed',
          section: 'For the chickpeas',
        ),
        RecipeIngredient(
          amount: '1 teaspoon',
          name: 'ground turmeric',
          section: 'For the chickpeas',
        ),
        RecipeIngredient(
          amount: '1 tablespoon',
          name: 'fresh ginger, grated',
          section: 'For the chickpeas',
        ),
        RecipeIngredient(
          amount: '1 handful',
          name: 'fresh herbs (dill, mint)',
          section: 'To finish',
        ),
        RecipeIngredient(
          amount: '½ cup',
          name: 'pomegranate seeds',
          section: 'To finish',
        ),
      ],
      steps: const [
        RecipeStep(
          number: 1,
          text:
              'Heat the oven to 425°F. Toss squash with 2 tablespoons oil and salt; roast 25 minutes until tender.',
          minutes: 25,
        ),
        RecipeStep(
          number: 2,
          text:
              'Warm remaining oil in a skillet. Add chickpeas, turmeric and ginger; cook until fragrant and crisp at the edges, 8 minutes.',
          minutes: 8,
        ),
        RecipeStep(
          number: 3,
          text:
              'Plate squash, spoon chickpeas over, and scatter herbs and pomegranate. Serve warm.',
          minutes: 5,
        ),
      ],
    ),
    Recipe(
      id: 'chili',
      title: 'Vegetarian Skillet Chili',
      author: 'Melissa Clark',
      blurb:
          'A weeknight chili that leans on beans, warm spices and a quick pickle of red onion for crunch.',
      image: AppAssets.recipeChili,
      yieldText: '4 servings',
      timeText: '40 minutes',
      minutes: 40,
      categories: const ['Dinner', 'Vegetarian', 'Easy'],
      collection: 'one-pot',
      ingredients: const [
        RecipeIngredient(
          amount: '1',
          name: 'red onion or shallot, thinly sliced',
        ),
        RecipeIngredient(amount: '2 tablespoons', name: 'grapeseed oil'),
        RecipeIngredient(amount: '1 teaspoon', name: 'dried oregano'),
        RecipeIngredient(amount: '2 (15-ounce) cans', name: 'beans, drained'),
        RecipeIngredient(
          amount: 'to taste',
          name: 'fresh cilantro, diced avocado and sour cream',
        ),
      ],
      steps: const [
        RecipeStep(
          number: 1,
          text:
              'Sauté onion in oil until soft. Stir in oregano and chili spices.',
          minutes: 8,
        ),
        RecipeStep(
          number: 2,
          text:
              'Add beans and a splash of water; simmer until thick and saucy.',
          minutes: 20,
        ),
        RecipeStep(
          number: 3,
          text: 'Top with cilantro, avocado and a spoon of sour cream.',
          minutes: 5,
        ),
      ],
    ),
    Recipe(
      id: 'salmon',
      title: 'Maple and Miso Sheet-Pan Salmon',
      author: 'Colu Henry',
      blurb:
          'Sweet-salty miso glaze meets maple; green beans roast beside the fish for a one-pan dinner.',
      image: AppAssets.recipeSalmon,
      yieldText: '4 servings',
      timeText: '30 minutes',
      minutes: 30,
      categories: const ['Dinner', 'Quick', 'Healthy'],
      collection: 'one-pot',
      ingredients: const [
        RecipeIngredient(amount: '4', name: 'salmon fillets'),
        RecipeIngredient(amount: '2 tablespoons', name: 'white miso'),
        RecipeIngredient(amount: '1 tablespoon', name: 'maple syrup'),
        RecipeIngredient(amount: '12 ounces', name: 'green beans, trimmed'),
        RecipeIngredient(amount: '1 tablespoon', name: 'olive oil'),
      ],
      steps: const [
        RecipeStep(
          number: 1,
          text:
              'Whisk miso and maple. Toss green beans with oil on a sheet pan.',
          minutes: 5,
        ),
        RecipeStep(
          number: 2,
          text:
              'Nestle salmon on the pan, brush with glaze, roast at 400°F for 15 minutes.',
          minutes: 15,
        ),
        RecipeStep(
          number: 3,
          text: 'Rest 2 minutes and serve with lemon wedges.',
          minutes: 2,
        ),
      ],
    ),
    Recipe(
      id: 'pasta',
      title: 'One-Pot Pasta With Ricotta and Lemon',
      author: 'Ali Slagle',
      blurb:
          'Creamy lemon ricotta coats the pasta in the same pot — weeknight comfort without a second dish.',
      image: AppAssets.recipePasta,
      yieldText: '4 servings',
      timeText: '25 minutes',
      minutes: 25,
      categories: const ['Dinner', 'Pasta', 'Easy', 'Quick'],
      collection: 'one-pot',
      ingredients: const [
        RecipeIngredient(amount: '12 ounces', name: 'short pasta'),
        RecipeIngredient(amount: '1 cup', name: 'whole-milk ricotta'),
        RecipeIngredient(amount: '1', name: 'lemon, zest and juice'),
        RecipeIngredient(amount: '½ cup', name: 'grated Parmesan'),
        RecipeIngredient(amount: '2 tablespoons', name: 'olive oil'),
      ],
      steps: const [
        RecipeStep(
          number: 1,
          text:
              'Boil pasta in a wide pot until just shy of al dente; reserve a cup of water.',
          minutes: 10,
        ),
        RecipeStep(
          number: 2,
          text:
              'Stir in ricotta, lemon, Parmesan and oil with splash of pasta water.',
          minutes: 5,
        ),
        RecipeStep(
          number: 3,
          text: 'Season generously with black pepper and serve immediately.',
          minutes: 2,
        ),
      ],
    ),
    Recipe(
      id: 'chicken',
      title: 'Sheet-Pan Chicken With Potatoes and Capers',
      author: 'Kay Chun',
      blurb:
          'Crisp chicken thighs, golden potatoes and briny capers — a Sunday plate on a Tuesday timeline.',
      image: AppAssets.recipeChicken,
      yieldText: '4 servings',
      timeText: '50 minutes',
      minutes: 50,
      categories: const ['Dinner', 'Easy'],
      collection: 'one-pot',
      ingredients: const [
        RecipeIngredient(amount: '6', name: 'bone-in chicken thighs'),
        RecipeIngredient(amount: '1½ pounds', name: 'baby potatoes, halved'),
        RecipeIngredient(amount: '2 tablespoons', name: 'capers'),
        RecipeIngredient(amount: '4', name: 'scallions, sliced'),
        RecipeIngredient(amount: '3 tablespoons', name: 'olive oil'),
      ],
      steps: const [
        RecipeStep(
          number: 1,
          text: 'Toss potatoes with oil and salt; roast 15 minutes at 425°F.',
          minutes: 15,
        ),
        RecipeStep(
          number: 2,
          text:
              'Add chicken skin-side up; roast until juices run clear, about 30 minutes.',
          minutes: 30,
        ),
        RecipeStep(
          number: 3,
          text: 'Scatter capers and scallions over and rest 5 minutes.',
          minutes: 5,
        ),
      ],
    ),
    Recipe(
      id: 'cake',
      title: "Devil's Food Cake With Black Pepper Buttercream",
      author: 'Melissa Clark',
      blurb:
          'A six-layer beauty with deeply fudgy flavor, light crumb, and a surprising peppered buttercream.',
      image: AppAssets.recipeCake,
      yieldText: '10 servings',
      timeText: '2½ hours',
      minutes: 150,
      categories: const ['Dessert'],
      collection: 'weekend',
      ingredients: const [
        RecipeIngredient(
          amount: '10 tablespoons',
          name: 'unsalted butter, softened',
          section: 'For the cake',
        ),
        RecipeIngredient(
          amount: '⅔ cup',
          name: 'unsweetened natural cocoa powder',
          section: 'For the cake',
        ),
        RecipeIngredient(
          amount: '¾ cup',
          name: 'whole milk',
          section: 'For the cake',
        ),
        RecipeIngredient(
          amount: '2 cups',
          name: 'cake flour',
          section: 'For the cake',
        ),
        RecipeIngredient(
          amount: '1½ teaspoons',
          name: 'baking soda',
          section: 'For the cake',
        ),
        RecipeIngredient(
          amount: '½ teaspoon',
          name: 'baking powder',
          section: 'For the cake',
        ),
        RecipeIngredient(
          amount: '3 sticks',
          name: 'butter, for frosting',
          section: 'For the buttercream',
        ),
        RecipeIngredient(
          amount: '1 teaspoon',
          name: 'freshly ground black pepper',
          section: 'For the buttercream',
        ),
      ],
      steps: const [
        RecipeStep(
          number: 1,
          text:
              'Cream butter and sugar; whisk in cocoa and milk. Fold dry ingredients.',
          minutes: 20,
        ),
        RecipeStep(
          number: 2,
          text: 'Bake thin layers at 350°F until a tester comes out clean.',
          minutes: 25,
        ),
        RecipeStep(
          number: 3,
          text:
              'Whip buttercream with pepper; stack and frost the cooled layers.',
          minutes: 30,
        ),
      ],
    ),
    Recipe(
      id: 'shabu',
      title: 'Vegetable Shabu Shabu in Kombu-Ginger Broth',
      author: 'Hetty Lui McKinnon',
      blurb:
          'A gentle simmer bath of kombu and ginger for mushrooms, greens and tofu — dinner as a ritual.',
      image: AppAssets.recipeShabu,
      yieldText: '4 to 6 servings',
      timeText: '35 minutes',
      minutes: 35,
      categories: const ['Dinner', 'Vegetarian', 'Healthy'],
      collection: 'weekend',
      ingredients: const [
        RecipeIngredient(amount: '1 piece', name: 'dried kombu'),
        RecipeIngredient(amount: '2-inch piece', name: 'ginger, sliced'),
        RecipeIngredient(amount: '8 ounces', name: 'mixed mushrooms'),
        RecipeIngredient(amount: '1 block', name: 'silken tofu, cubed'),
        RecipeIngredient(amount: '4 cups', name: 'leafy greens'),
      ],
      steps: const [
        RecipeStep(
          number: 1,
          text: 'Simmer kombu and ginger in water 15 minutes; discard solids.',
          minutes: 15,
        ),
        RecipeStep(
          number: 2,
          text:
              'Bring broth to a gentle boil. Cook mushrooms and tofu in batches.',
          minutes: 12,
        ),
        RecipeStep(
          number: 3,
          text: 'Finish with greens; ladle into bowls with dipping sauces.',
          minutes: 5,
        ),
      ],
    ),
    Recipe(
      id: 'pie',
      title: 'Strawberry Pretzel Pie',
      author: 'Eric Kim',
      blurb:
          'Salty pretzel crust, creamy middle, and a jewel-bright strawberry top — picnic dessert energy.',
      image: AppAssets.recipePie,
      yieldText: '8 servings',
      timeText: '1 hour 20 minutes',
      minutes: 80,
      categories: const ['Dessert'],
      collection: 'weekend',
      ingredients: const [
        RecipeIngredient(amount: '2 cups', name: 'crushed pretzels'),
        RecipeIngredient(amount: '½ cup', name: 'melted butter'),
        RecipeIngredient(amount: '8 ounces', name: 'cream cheese'),
        RecipeIngredient(amount: '1 pound', name: 'fresh strawberries'),
        RecipeIngredient(amount: '1 packet', name: 'strawberry gelatin'),
      ],
      steps: const [
        RecipeStep(
          number: 1,
          text: 'Press pretzel crust into a pie tin; bake 10 minutes and cool.',
          minutes: 15,
        ),
        RecipeStep(
          number: 2,
          text: 'Whip cream cheese layer and spread over crust.',
          minutes: 10,
        ),
        RecipeStep(
          number: 3,
          text: 'Set strawberries in gelatin; chill until firm.',
          minutes: 60,
        ),
      ],
    ),
    Recipe(
      id: 'avocado',
      title: 'Smashed Avocado Toast With Soft Eggs',
      author: 'Alexa Weibel',
      blurb:
          'Creamy avocado on thick toast, soft eggs and chili oil — the breakfast that never goes out of style.',
      image: AppAssets.recipeAvocado,
      yieldText: '2 servings',
      timeText: '15 minutes',
      minutes: 15,
      categories: const ['Breakfast', 'Brunch', 'Quick', 'Vegetarian'],
      collection: 'morning',
      ingredients: const [
        RecipeIngredient(amount: '2 slices', name: 'sourdough'),
        RecipeIngredient(amount: '1', name: 'ripe avocado'),
        RecipeIngredient(amount: '2', name: 'eggs'),
        RecipeIngredient(amount: '1 teaspoon', name: 'chili oil'),
        RecipeIngredient(amount: 'to taste', name: 'flaky salt and lemon'),
      ],
      steps: const [
        RecipeStep(
          number: 1,
          text: 'Toast the bread. Mash avocado with lemon and salt.',
          minutes: 5,
        ),
        RecipeStep(
          number: 2,
          text: 'Soft-boil or fry the eggs to your liking.',
          minutes: 7,
        ),
        RecipeStep(
          number: 3,
          text: 'Spread avocado, top with eggs and a drizzle of chili oil.',
          minutes: 2,
        ),
      ],
    ),
    Recipe(
      id: 'salad',
      title: 'Citrus Herb Grain Salad',
      author: 'Hetty Lui McKinnon',
      blurb:
          'Bright citrus, soft herbs and chewy grains — a lunch bowl that keeps well until tomorrow.',
      image: AppAssets.recipeSalad,
      yieldText: '4 servings',
      timeText: '30 minutes',
      minutes: 30,
      categories: const ['Lunch', 'Salad', 'Vegetarian', 'Healthy'],
      collection: 'morning',
      ingredients: const [
        RecipeIngredient(amount: '1½ cups', name: 'cooked farro or quinoa'),
        RecipeIngredient(amount: '2', name: 'oranges, segmented'),
        RecipeIngredient(amount: '1 cup', name: 'mixed soft herbs'),
        RecipeIngredient(amount: '3 tablespoons', name: 'olive oil'),
        RecipeIngredient(amount: '1 tablespoon', name: 'white wine vinegar'),
      ],
      steps: const [
        RecipeStep(
          number: 1,
          text: 'Whisk oil and vinegar with salt and pepper.',
          minutes: 3,
        ),
        RecipeStep(
          number: 2,
          text: 'Toss grains with citrus, herbs and dressing.',
          minutes: 5,
        ),
        RecipeStep(
          number: 3,
          text: 'Serve cool or room temperature with extra herbs.',
          minutes: 1,
        ),
      ],
    ),
    Recipe(
      id: 'soup',
      title: 'Roasted Tomato Soup With Herb Oil',
      author: 'Melissa Clark',
      blurb:
          'Oven-roasted tomatoes become a silky soup finished with a bright herb oil.',
      image: AppAssets.recipeSoup,
      yieldText: '4 servings',
      timeText: '55 minutes',
      minutes: 55,
      categories: const ['Lunch', 'Dinner', 'Vegetarian'],
      collection: 'weekend',
      ingredients: const [
        RecipeIngredient(amount: '3 pounds', name: 'ripe tomatoes'),
        RecipeIngredient(amount: '1', name: 'onion, quartered'),
        RecipeIngredient(amount: '4 cloves', name: 'garlic'),
        RecipeIngredient(amount: '3 cups', name: 'vegetable stock'),
        RecipeIngredient(amount: '¼ cup', name: 'herb oil'),
      ],
      steps: const [
        RecipeStep(
          number: 1,
          text: 'Roast tomatoes, onion and garlic at 425°F until blistered.',
          minutes: 35,
        ),
        RecipeStep(
          number: 2,
          text: 'Blend with stock until smooth; simmer 10 minutes.',
          minutes: 10,
        ),
        RecipeStep(
          number: 3,
          text: 'Ladle into bowls and swirl with herb oil.',
          minutes: 2,
        ),
      ],
    ),
    Recipe(
      id: 'pancakes',
      title: 'Buttermilk Pancakes With Berries',
      author: 'Genevieve Ko',
      blurb:
          'Tall, tender pancakes with a buttermilk tang — pile on berries and a ribbon of syrup.',
      image: AppAssets.recipePancakes,
      yieldText: '4 servings',
      timeText: '35 minutes',
      minutes: 35,
      categories: const ['Breakfast', 'Brunch', 'Easy'],
      collection: 'morning',
      ingredients: const [
        RecipeIngredient(amount: '2 cups', name: 'all-purpose flour'),
        RecipeIngredient(amount: '2 cups', name: 'buttermilk'),
        RecipeIngredient(amount: '2', name: 'eggs'),
        RecipeIngredient(amount: '2 tablespoons', name: 'melted butter'),
        RecipeIngredient(amount: '2 cups', name: 'mixed berries'),
      ],
      steps: const [
        RecipeStep(
          number: 1,
          text: 'Whisk dry ingredients; fold in buttermilk, eggs and butter.',
          minutes: 8,
        ),
        RecipeStep(
          number: 2,
          text: 'Cook scoops on a greased griddle until bubbles set.',
          minutes: 15,
        ),
        RecipeStep(
          number: 3,
          text: 'Stack high; top with berries and warm maple syrup.',
          minutes: 3,
        ),
      ],
    ),
  ];

  static final List<RecipeCollection> collections = [
    const RecipeCollection(
      id: 'one-pot',
      title: 'Because the Dishwasher Is You',
      subtitle: '46 delicious one-pot (or pan) dinners',
      recipeIds: ['chili', 'salmon', 'pasta', 'chicken', 'squash-chickpeas'],
      tint: 1,
    ),
    const RecipeCollection(
      id: 'morning',
      title: 'Slow Mornings',
      subtitle: 'Breakfast and brunch worth lingering over',
      recipeIds: ['avocado', 'pancakes', 'salad'],
      tint: 0,
    ),
    const RecipeCollection(
      id: 'weekend',
      title: 'Weekend Projects',
      subtitle: 'Bakes and broths for when you have the time',
      recipeIds: ['cake', 'pie', 'shabu', 'soup'],
      tint: 2,
    ),
  ];

  static final List<String> suggestions = [
    'Vegetarian',
    'Vegan',
    'Healthy',
    'Dinner',
    'Dessert',
    'Easy',
    'Studio Classics',
  ];

  static final List<String> mealTypes = [
    'Appetizer',
    'Breakfast',
    'Brunch',
    'Dessert',
    'Dinner',
    'Easy',
    'For One',
    'For Two',
    'Lunch',
    'Main Course',
    'Pasta',
    'Quick',
    'Salad',
    'Side Dish',
    'Snack',
    'Weekday',
  ];

  static Recipe byId(String id) =>
      all.firstWhere((r) => r.id == id, orElse: () => all.first);

  static List<Recipe> byCategory(String category) => all
      .where(
        (r) =>
            r.categories.any((c) => c.toLowerCase() == category.toLowerCase()),
      )
      .toList();

  static List<Recipe> search(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return all;
    return all
        .where(
          (r) =>
              r.title.toLowerCase().contains(q) ||
              r.author.toLowerCase().contains(q) ||
              r.categories.any((c) => c.toLowerCase().contains(q)) ||
              r.blurb.toLowerCase().contains(q),
        )
        .toList();
  }

  static List<Recipe> inCollection(String collectionId) {
    final c = collections.firstWhere(
      (e) => e.id == collectionId,
      orElse: () => collections.first,
    );
    return c.recipeIds.map(byId).toList();
  }
}
