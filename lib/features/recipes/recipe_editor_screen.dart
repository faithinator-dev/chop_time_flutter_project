import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/recipe.dart';
import '../../providers/user_recipe_providers.dart';
import '../../theme/app_colors.dart';

class RecipeEditorScreen extends ConsumerStatefulWidget {
  const RecipeEditorScreen({super.key, this.recipeId});

  final String? recipeId;

  @override
  ConsumerState<RecipeEditorScreen> createState() => _RecipeEditorScreenState();
}

class _RecipeEditorScreenState extends ConsumerState<RecipeEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _servings = TextEditingController(text: '2 servings');
  final _minutes = TextEditingController(text: '30');
  final _categories = TextEditingController(text: 'Dinner');
  final _ingredients = TextEditingController();
  final _steps = TextEditingController();
  bool _initialized = false;
  bool _saving = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized || widget.recipeId == null) {
      _initialized = true;
      return;
    }
    final recipe = ref.read(recipeByIdProvider(widget.recipeId!));
    if (recipe != null) {
      _title.text = recipe.title;
      _description.text = recipe.blurb;
      _servings.text = recipe.yieldText;
      _minutes.text = recipe.minutes.toString();
      _categories.text = recipe.categories.join(', ');
      _ingredients.text = recipe.ingredients
          .map((item) => '${item.amount} | ${item.name}')
          .join('\n');
      _steps.text = recipe.steps.map((step) => step.text).join('\n');
    }
    _initialized = true;
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _servings.dispose();
    _minutes.dispose();
    _categories.dispose();
    _ingredients.dispose();
    _steps.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final ingredientItems = _ingredients.text
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .map((line) {
          final parts = line.split('|');
          return RecipeIngredient(
            amount: parts.length > 1 ? parts.first.trim() : '',
            name: parts.length > 1 ? parts.sublist(1).join('|').trim() : line,
          );
        })
        .where((item) => item.name.isNotEmpty)
        .toList();
    final stepItems = _steps.text
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    if (ingredientItems.isEmpty || stepItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Add at least one ingredient and one cooking step.'),
        ),
      );
      return;
    }

    setState(() => _saving = true);
    final minutes = int.tryParse(_minutes.text.trim()) ?? 30;
    final existing = widget.recipeId == null
        ? null
        : ref.read(recipeByIdProvider(widget.recipeId!));
    final recipe = Recipe(
      id: widget.recipeId ??
          'user-${DateTime.now().microsecondsSinceEpoch}',
      title: _title.text.trim(),
      author: 'You',
      blurb: _description.text.trim(),
      image: existing?.image ?? '',
      yieldText: _servings.text.trim(),
      timeText: '$minutes minutes',
      minutes: minutes,
      categories: _categories.text
          .split(',')
          .map((value) => value.trim())
          .where((value) => value.isNotEmpty)
          .toList(),
      ingredients: ingredientItems,
      steps: [
        for (var i = 0; i < stepItems.length; i++)
          RecipeStep(number: i + 1, text: stepItems[i]),
      ],
    );

    try {
      final notifier = ref.read(userRecipesProvider.notifier);
      if (widget.recipeId == null) {
        await notifier.add(recipe);
      } else {
        await notifier.update(recipe);
      }
      if (!mounted) return;
      context.go('/recipe/${recipe.id}');
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not save this recipe. Try again.')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final editing = widget.recipeId != null;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(editing ? 'Edit recipe' : 'Create a recipe'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 36),
          children: [
            Text(
              'Make it yours',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 6),
            Text(
              'Add the details so you can cook from this recipe whenever you need it.',
              style: Theme.of(context)
                  .textTheme.bodyMedium
                  ?.copyWith(color: colors.muted),
            ),
            const SizedBox(height: 22),
            _field(_title, 'Recipe name', required: true),
            _field(_description, 'Short description', maxLines: 3),
            Row(
              children: [
                Expanded(child: _field(_servings, 'Servings')),
                const SizedBox(width: 12),
                Expanded(
                  child: _field(
                    _minutes,
                    'Minutes',
                    keyboardType: TextInputType.number,
                    required: true,
                  ),
                ),
              ],
            ),
            _field(_categories, 'Categories (comma separated)'),
            const SizedBox(height: 12),
            Text('Ingredients', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 5),
            Text(
              'One per line. Use amount | ingredient, for example: 2 cups | rice',
              style: Theme.of(context)
                  .textTheme.bodySmall
                  ?.copyWith(color: colors.muted),
            ),
            const SizedBox(height: 8),
            _field(_ingredients, 'Ingredients', maxLines: 6, required: true),
            const SizedBox(height: 16),
            Text('Cooking steps',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 5),
            Text(
              'Write each step on a separate line, in cooking order.',
              style: Theme.of(context)
                  .textTheme.bodySmall
                  ?.copyWith(color: colors.muted),
            ),
            const SizedBox(height: 8),
            _field(_steps, 'Step 1\nStep 2\nStep 3',
                maxLines: 7, required: true),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _saving ? null : _save,
              icon: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save_outlined),
              label: Text(_saving ? 'Saving…' : 'Save recipe'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    bool required = false,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType ??
            (maxLines > 1 ? TextInputType.multiline : TextInputType.text),
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: label,
          alignLabelWithHint: maxLines > 1,
        ),
        validator: required
            ? (value) => value == null || value.trim().isEmpty
                ? 'This field is required'
                : null
            : null,
      ),
    );
  }
}
