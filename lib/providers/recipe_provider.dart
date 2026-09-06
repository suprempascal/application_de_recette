import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../data/recipes.dart';

class RecipeProvider extends ChangeNotifier {
  final List<Recipe> _recipes = List.from(mockRecipes);
  String _searchQuery = '';
  String _selectedCategory = 'Tous';

  List<Recipe> get recipes => _recipes;

  List<String> get categories {
    final cats = _recipes.map((r) => r.category).toSet().toList();
    return ['Tous', ...cats];
  }

  List<Recipe> get filteredRecipes {
    return _recipes.where((recipe) {
      final matchesSearch = recipe.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          recipe.description.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'Tous' || recipe.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  List<Recipe> get favoriteRecipes {
    return _recipes.where((r) => r.isFavorite).toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void toggleFavorite(String recipeId) {
    final index = _recipes.indexWhere((r) => r.id == recipeId);
    if (index != -1) {
      _recipes[index] = _recipes[index].copyWith(
        isFavorite: !_recipes[index].isFavorite,
      );
      notifyListeners();
    }
  }

  void addRecipe(Recipe recipe) {
    final newRecipe = recipe.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    _recipes.add(newRecipe);
    notifyListeners();
  }

  Recipe? getRecipeById(String id) {
    try {
      return _recipes.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }
}
