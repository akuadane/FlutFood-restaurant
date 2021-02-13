class Ingredient {
  final int id;
  final String name;
  final String description;

  const Ingredient({this.id, this.name, this.description});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
