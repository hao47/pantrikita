// To parse this JSON data, do
//
//     final recipe = recipeFromJson(jsonString);

import 'dart:convert';

Recipe recipeFromJson(String str) => Recipe.fromJson(json.decode(str));

String recipeToJson(Recipe data) => json.encode(data.toJson());

class Recipe {
  String status;
  List<Data> data;

  Recipe({
    required this.status,
    required this.data,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    status: json["status"] ?? "",
    data: json["data"] != null
        ? List<Data>.from(json["data"].map((x) => Data.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Data {
  String id;
  String title;
  String description;
  String? difficulty;
  String? culturalHeritage;
  String? location;
  String? cookTime;
  String? servingsPortion;
  List<Ingredient> youHave;
  List<Ingredient> youNeed;

  Data({
    required this.id,
    required this.title,
    required this.description,
    this.difficulty,
    this.culturalHeritage,
    this.location,
    this.cookTime,
    this.servingsPortion,
    required this.youHave,
    required this.youNeed,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] ?? "",
    title: json["title"] ?? "",
    description: json["description"] ?? "",
    difficulty: json["difficulty"],
    culturalHeritage: json["cultural_heritage"],
    location: json["location"],
    cookTime: json["cook_time"],
    servingsPortion: json["servings_portion"],
    youHave: json["you_have"] != null
        ? _parseIngredients(json["you_have"])
        : [],
    youNeed: json["you_need"] != null
        ? _parseIngredients(json["you_need"])
        : [],
  );

  static List<Ingredient> _parseIngredients(dynamic ingredientsData) {
    if (ingredientsData is List) {
      return ingredientsData.map((item) {
        if (item is String) {
          // Handle string format: ["Organic Milk", "Bread"]
          return Ingredient(name: item, isCheck: false);
        } else if (item is Map<String, dynamic>) {
          // Handle object format: [{"name": "...", "is_check": true}]
          return Ingredient.fromJson(item);
        } else {
          // Fallback for unknown format
          return Ingredient(name: item.toString(), isCheck: false);
        }
      }).toList();
    }
    return [];
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "difficulty": difficulty,
    "cultural_heritage": culturalHeritage,
    "location": location,
    "cook_time": cookTime,
    "servings_portion": servingsPortion,
    "you_have": List<dynamic>.from(youHave.map((x) => x.toJson())),
    "you_need": List<dynamic>.from(youNeed.map((x) => x.toJson())),
  };
}

class Ingredient {
  String name;
  bool isCheck;

  Ingredient({
    required this.name,
    required this.isCheck,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
    name: json["name"] ?? "",
    isCheck: json["is_check"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "is_check": isCheck,
  };
}