import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import '../widgets/recipe_card.dart';
import '../widgets/search_filter_bar.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Recettes'),
        centerTitle: true,
      ),
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final isTablet = constraints.maxWidth > 600;
              final recipes = provider.filteredRecipes;

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchFilterBar(
                      searchQuery: '',
                      onSearchChanged: provider.setSearchQuery,
                      categories: provider.categories,
                      selectedCategory: provider.recipes.isEmpty ? 'Tous' : 'Tous',
                      onCategorySelected: provider.setSelectedCategory,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${recipes.length} recette${recipes.length > 1 ? 's' : ''}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: recipes.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 64,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Aucune recette trouvée',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                            )
                          : GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: isTablet ? 3 : 2,
                                childAspectRatio: 0.75,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: recipes.length,
                              itemBuilder: (context, index) {
                                final recipe = recipes[index];
                                return RecipeCard(
                                  recipe: recipe,
                                  onTap: () {
                                    context.push('/recipe/${recipe.id}');
                                  },
                                  onFavoriteToggle: () {
                                    provider.toggleFavorite(recipe.id);
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
