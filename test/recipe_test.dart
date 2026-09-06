import 'package:flutter/material.dart';
import 'package:flutter_recettes/providers/recipe_provider.dart';
import 'package:flutter_recettes/screens/recipes_screen.dart';
import 'package:flutter_recettes/widgets/rating_widget.dart';
import 'package:flutter_recettes/widgets/search_filter_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('RatingWidget displays correct rating', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RatingWidget(rating: 4.5),
        ),
      ),
    );

    expect(find.text('4.5'), findsOneWidget);
    expect(find.byIcon(Icons.star), findsNWidgets(4));
    expect(find.byIcon(Icons.star_half), findsOneWidget);
  });

  testWidgets('RecipeProvider filters by search query', (WidgetTester tester) async {
    final provider = RecipeProvider();

    provider.setSearchQuery('poulet');
    expect(provider.filteredRecipes.length, greaterThan(0));

    provider.setSearchQuery('recetteinexistante');
    expect(provider.filteredRecipes, isEmpty);
  });

  testWidgets('RecipeProvider filters by category', (WidgetTester tester) async {
    final provider = RecipeProvider();

    provider.setSelectedCategory('Dessert');
    final desserts = provider.filteredRecipes;
    expect(desserts, isNotEmpty);
    expect(desserts.every((r) => r.category == 'Dessert'), isTrue);
  });

  testWidgets('RecipeProvider toggles favorites', (WidgetTester tester) async {
    final provider = RecipeProvider();
    final recipe = provider.recipes.first;

    provider.toggleFavorite(recipe.id);
    expect(provider.favoriteRecipes.length, 1);

    provider.toggleFavorite(recipe.id);
    expect(provider.favoriteRecipes, isEmpty);
  });

  testWidgets('RecipesScreen renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => RecipeProvider()),
        ],
        child: const MaterialApp(
          home: RecipesScreen(),
        ),
      ),
    );

    expect(find.text('Mes Recettes'), findsOneWidget);
    expect(find.byType(GridView), findsWidgets);
    expect(find.byType(SearchFilterBar), findsOneWidget);
  });
}