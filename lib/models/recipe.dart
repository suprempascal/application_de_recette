// Definition de la structur de donnees pour une recette

class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final int duration;
  final int servings;
  final double rating;
  final List<String> ingredients;
  final List<String> steps;
  final bool isFavorite;

  const Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.duration,
    required this.servings,
    required this.rating,
    required this.ingredients,
    required this.steps,
    this.isFavorite = false,
  });

  Recipe copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? category,
    int? duration,
    int? servings,
    double? rating,
    List<String>? ingredients,
    List<String>? steps,
    bool? isFavorite,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      duration: duration ?? this.duration,
      servings: servings ?? this.servings,
      rating: rating ?? this.rating,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
