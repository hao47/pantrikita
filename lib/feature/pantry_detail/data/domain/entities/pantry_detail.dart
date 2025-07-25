// To parse this JSON data, do
//
//     final pantryDetail = pantryDetailFromJson(jsonString);

import 'dart:convert';

PantryDetail pantryDetailFromJson(String str) => PantryDetail.fromJson(json.decode(str));

String pantryDetailToJson(PantryDetail data) => json.encode(data.toJson());

class PantryDetail {
  Data data;

  PantryDetail({
    required this.data,
  });

  factory PantryDetail.fromJson(Map<String, dynamic> json) => PantryDetail(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  String id;
  String icon;
  String name;
  String category;
  Status headerStatus;
  Status bodyStatus;
  String expiringDate;
  String location;
  List<Recipe> recipe;
  List<UseEverything> useEverything;
  Composting composting;

  Data({
    required this.id,
    required this.icon,
    required this.name,
    required this.category,
    required this.headerStatus,
    required this.bodyStatus,
    required this.expiringDate,
    required this.location,
    required this.recipe,
    required this.useEverything,
    required this.composting,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    icon: json["icon"],
    name: json["name"],
    category: json["category"],
    headerStatus: Status.fromJson(json["header_status"]),
    bodyStatus: Status.fromJson(json["body_status"]),
    expiringDate: json["expiring_date"],
    location: json["location"],
    recipe: List<Recipe>.from(json["recipe"].map((x) => Recipe.fromJson(x))),
    useEverything: List<UseEverything>.from(json["use_everything"].map((x) => UseEverything.fromJson(x))),
    composting: Composting.fromJson(json["composting"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "icon": icon,
    "name": name,
    "category": category,
    "header_status": headerStatus.toJson(),
    "body_status": bodyStatus.toJson(),
    "expiring_date": expiringDate,
    "location": location,
    "recipe": List<dynamic>.from(recipe.map((x) => x.toJson())),
    "use_everything": List<dynamic>.from(useEverything.map((x) => x.toJson())),
    "composting": composting.toJson(),
  };
}

class Status {
  String statusText;
  String statusColor;

  Status({
    required this.statusText,
    required this.statusColor,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    statusText: json["status_text"],
    statusColor: json["status_color"],
  );

  Map<String, dynamic> toJson() => {
    "status_text": statusText,
    "status_color": statusColor,
  };
}

class Composting {
  String enviromentalImpact;
  List<String> orders;

  Composting({
    required this.enviromentalImpact,
    required this.orders,
  });

  factory Composting.fromJson(Map<String, dynamic> json) => Composting(
    enviromentalImpact: json["enviromental_impact"],
    orders: List<String>.from(json["orders"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "enviromental_impact": enviromentalImpact,
    "orders": List<dynamic>.from(orders.map((x) => x)),
  };
}

class Recipe {
  String id;
  String title;
  String description;
  String difficulty;
  String cookTime;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.cookTime,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    difficulty: json["difficulty"],
    cookTime: json["cook_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "difficulty": difficulty,
    "cook_time": cookTime,
  };
}

class UseEverything {
  String id;
  String title;
  String description;
  String cookTime;
  String difficulty;
  String ingredient;
  String instruction;

  UseEverything({
    required this.id,
    required this.title,
    required this.description,
    required this.cookTime,
    required this.difficulty,
    required this.ingredient,
    required this.instruction,
  });

  factory UseEverything.fromJson(Map<String, dynamic> json) => UseEverything(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    cookTime: json["cook_time"],
    difficulty: json["difficulty"],
    ingredient: json["ingredient"],
    instruction: json["instruction"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "cook_time": cookTime,
    "difficulty": difficulty,
    "ingredient": ingredient,
    "instruction": instruction,
  };
}
