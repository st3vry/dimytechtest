import 'dart:convert';
List<Coffee> postFromJson(String str) =>
    List<Coffee>.from(json.decode(str).map((x) => Coffee.fromMap(x)));
class Coffee {
  Coffee({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.image,
  });
  int id;
  String title;
  String description;
  String image;
  List ingredients;
  factory Coffee.fromMap(Map<String, dynamic> json) => Coffee(
        id : json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        ingredients: json["ingredients"],
      );
}