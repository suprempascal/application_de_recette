import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/recipe.dart';
import '../providers/recipe_provider.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _durationController = TextEditingController();
  final _servingsController = TextEditingController();
  final _ratingController = TextEditingController();
  String _selectedCategory = 'Plat Principal';
  final List<String> _ingredients = [];
  final List<String> _steps = [];
  final _ingredientController = TextEditingController();
  final _stepController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _durationController.dispose();
    _servingsController.dispose();
    _ratingController.dispose();
    _ingredientController.dispose();
    _stepController.dispose();
    super.dispose();
  }

  void _addIngredient() {
    if (_ingredientController.text.isNotEmpty) {
      setState(() {
        _ingredients.add(_ingredientController.text);
        _ingredientController.clear();
      });
    }
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  void _addStep() {
    if (_stepController.text.isNotEmpty) {
      setState(() {
        _steps.add(_stepController.text);
        _stepController.clear();
      });
    }
  }

  void _removeStep(int index) {
    setState(() {
      _steps.removeAt(index);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final recipe = Recipe(
        id: '',
        title: _titleController.text,
        description: _descriptionController.text,
        imageUrl: _imageUrlController.text.isNotEmpty
            ? _imageUrlController.text
            : 'https://images.unsplash.com/photo-1495521821757-a1efb6729352?w=800',
        category: _selectedCategory,
        duration: int.tryParse(_durationController.text) ?? 30,
        servings: int.tryParse(_servingsController.text) ?? 2,
        rating: double.tryParse(_ratingController.text) ?? 4.0,
        ingredients: _ingredients.isNotEmpty ? _ingredients : ['Ingrédient 1'],
        steps: _steps.isNotEmpty ? _steps : ['Étape 1'],
      );

      context.read<RecipeProvider>().addRecipe(recipe);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Recette ajoutée avec succès !'),
          backgroundColor: Colors.green,
        ),
      );

      context.go('/recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouvelle Recette'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Informations générales',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Titre de la recette *',
                  hintText: 'Ex: Poulet au citron',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  if (value.length < 3) {
                    return 'Le titre doit contenir au moins 3 caractères';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description *',
                  hintText: 'Décrivez votre recette...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.description),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une description';
                  }
                  if (value.length < 10) {
                    return 'La description doit contenir au moins 10 caractères';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(
                  labelText: 'URL de l\'image (optionnel)',
                  hintText: 'https://...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.image),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Détails',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Catégorie',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.category),
                ),
                items: const [
                  DropdownMenuItem(value: 'Plat Principal', child: Text('Plat Principal')),
                  DropdownMenuItem(value: 'Entrée', child: Text('Entrée')),
                  DropdownMenuItem(value: 'Dessert', child: Text('Dessert')),
                  DropdownMenuItem(value: 'Petit-Déjeuner', child: Text('Petit-Déjeuner')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _durationController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Durée (min) *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.access_time),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Requis';
                        }
                        if (int.tryParse(value) == null || int.parse(value) <= 0) {
                          return 'Nombre invalide';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _servingsController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Portions *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.people),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Requis';
                        }
                        if (int.tryParse(value) == null || int.parse(value) <= 0) {
                          return 'Nombre invalide';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ratingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Note (1-5)',
                  hintText: '4.5',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.star),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final rating = double.tryParse(value);
                    if (rating == null || rating < 1 || rating > 5) {
                      return 'Entrez une note entre 1 et 5';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Ingrédients',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _ingredientController,
                      decoration: InputDecoration(
                        hintText: 'Ajouter un ingrédient',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onSubmitted: (_) => _addIngredient(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _addIngredient,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              if (_ingredients.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(_ingredients.length, (index) {
                    return Chip(
                      label: Text(_ingredients[index]),
                      deleteIcon: const Icon(Icons.close, size: 18),
                      onDeleted: () => _removeIngredient(index),
                    );
                  }),
                ),
              ],
              const SizedBox(height: 24),
              Text(
                'Étapes de préparation',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _stepController,
                      decoration: InputDecoration(
                        hintText: 'Ajouter une étape',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onSubmitted: (_) => _addStep(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _addStep,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              if (_steps.isNotEmpty) ...[
                const SizedBox(height: 12),
                ...List.generate(_steps.length, (index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(_steps[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => _removeStep(index),
                      ),
                    ),
                  );
                }),
              ],
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Ajouter la recette',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
