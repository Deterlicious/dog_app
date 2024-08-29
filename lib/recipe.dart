class Recipe {
  final String id;
  final String name;
  final String imageUrl;
  final String instructions;

  Recipe({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['idMeal'],
      name: json['strMeal'],
      imageUrl: json['strMealThumb'],
      instructions: json['strInstructions'],
    );
  }
}
