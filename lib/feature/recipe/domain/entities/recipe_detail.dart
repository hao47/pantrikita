// To parse this JSON data, do
//
//     final recipeDetail = recipeDetailFromJson(jsonString);

import 'dart:convert';

RecipeDetail recipeDetailFromJson(String str) => RecipeDetail.fromJson(json.decode(str));

String recipeDetailToJson(RecipeDetail data) => json.encode(data.toJson());

class RecipeDetail {
  String status;
  RecipeDetailData data;

  RecipeDetail({
    required this.status,
    required this.data,
  });

  factory RecipeDetail.fromJson(Map<String, dynamic> json) => RecipeDetail(
    status: json["status"] ?? "",
    data: RecipeDetailData.fromJson(json["data"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class RecipeDetailData {
  String id;
  String title;
  String description;
  String? difficulty;
  String? culturalHeritage;
  String? location;
  String? cookTime;
  String? servingsPortion;
  List<DetailIngredient> ingredients;
  List<Instruction> instructions;

  RecipeDetailData({
    required this.id,
    required this.title,
    required this.description,
    this.difficulty,
    this.culturalHeritage,
    this.location,
    this.cookTime,
    this.servingsPortion,
    required this.ingredients,
    required this.instructions,
  });

  factory RecipeDetailData.fromJson(Map<String, dynamic> json) {
    print("🔍 Parsing RecipeDetailData JSON...");
    print("🔍 JSON keys: ${json.keys.toList()}");

    try {
      return RecipeDetailData(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        difficulty: json["difficulty"],
        culturalHeritage: json["cultural_heritage"],
        location: json["location"],
        cookTime: json["cook_time"],
        servingsPortion: json["servings_portion"],
        ingredients: _parseDetailIngredients(json["ingredients"]),
        instructions: _parseInstructions(json["instructions"]),
      );
    } catch (e) {
      print("💥 Error parsing RecipeDetailData: $e");
      rethrow;
    }
  }

  static List<DetailIngredient> _parseDetailIngredients(dynamic ingredientsData) {
    print("🔍 Parsing ingredients: ${ingredientsData.runtimeType}");

    if (ingredientsData == null) return [];

    if (ingredientsData is List) {
      return ingredientsData.map((item) {
        try {
          if (item is Map<String, dynamic>) {
            return DetailIngredient.fromJson(item);
          } else if (item is String) {
            return DetailIngredient(id: "", name: item, isCheck: false);
          } else {
            return DetailIngredient(id: "", name: item.toString(), isCheck: false);
          }
        } catch (e) {
          print("💥 Error parsing ingredient: $e");
          return DetailIngredient(id: "", name: "Unknown", isCheck: false);
        }
      }).toList();
    }
    return [];
  }

  static List<Instruction> _parseInstructions(dynamic instructionsData) {
    print("🔍 Parsing instructions: ${instructionsData.runtimeType}");

    if (instructionsData == null) {
      print("🔍 No instructions in API response");
      return [];
    }

    if (instructionsData is List) {
      return instructionsData.asMap().entries.map((entry) {
        try {
          final index = entry.key;
          final item = entry.value;

          if (item is Map<String, dynamic>) {
            return Instruction.fromJson(item);
          } else if (item is String) {
            return Instruction(step: index + 1, description: item);
          } else {
            return Instruction(step: index + 1, description: item.toString());
          }
        } catch (e) {
          print("💥 Error parsing instruction: $e");
          return Instruction(step: entry.key + 1, description: "Unknown instruction");
        }
      }).toList();
    } else if (instructionsData is String) {
      return [Instruction(step: 1, description: instructionsData)];
    }

    return [];
  }

  List<DetailIngredient> get youHave => ingredients.where((ingredient) => ingredient.isCheck).toList();
  List<DetailIngredient> get youNeed => ingredients.where((ingredient) => !ingredient.isCheck).toList();

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "difficulty": difficulty,
    "cultural_heritage": culturalHeritage,
    "location": location,
    "cook_time": cookTime,
    "servings_portion": servingsPortion,
    "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
    "instructions": List<dynamic>.from(instructions.map((x) => x.toJson())),
  };
}

class DetailIngredient {
  String id;
  String name;
  bool isCheck;

  DetailIngredient({
    required this.id,
    required this.name,
    required this.isCheck,
  });

  factory DetailIngredient.fromJson(Map<String, dynamic> json) {
    try {
      return DetailIngredient(
        id: json["id"]?.toString() ?? "",
        name: json["name"]?.toString() ?? "",
        isCheck: json["is_check"] ?? false,
      );
    } catch (e) {
      print("💥 Error parsing DetailIngredient: $e");
      print("💥 JSON data: $json");
      return DetailIngredient(
        id: "",
        name: "Unknown ingredient",
        isCheck: false,
      );
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "is_check": isCheck,
  };
}

class Instruction {
  int step;
  String description;

  Instruction({
    required this.step,
    required this.description,
  });

  factory Instruction.fromJson(Map<String, dynamic> json) {
    try {
      return Instruction(
        step: json["step"] ?? 0,
        description: json["description"]?.toString() ?? "",
      );
    } catch (e) {
      print("💥 Error parsing Instruction: $e");
      print("💥 JSON data: $json");
      return Instruction(
        step: 0,
        description: "Unknown instruction",
      );
    }
  }

  Map<String, dynamic> toJson() => {
    "step": step,
    "description": description,
  };
}