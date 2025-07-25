// To parse this JSON data, do
//
//     final pantry = pantryFromJson(jsonString);

import 'dart:convert';

Pantry pantryFromJson(String str) => Pantry.fromJson(json.decode(str));

String pantryToJson(Pantry data) => json.encode(data.toJson());

class Pantry {
  Data data;

  Pantry({
    required this.data,
  });

  factory Pantry.fromJson(Map<String, dynamic> json) => Pantry(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  TotalItems totalItems;
  List<Item> items;

  Data({
    required this.totalItems,
    required this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalItems: TotalItems.fromJson(json["total_items"]),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_items": totalItems.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  String id;
  String name;
  String location;
  String status;
  String category;
  Expired expired;
  String? icon;

  Item({
    required this.id,
    required this.name,
    required this.location,
    required this.status,
    required this.category,
    required this.expired,
    this.icon,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    name: json["name"],
    location: json["location"],
    status: json["status"],
    category: json["category"],
    expired: Expired.fromJson(json["expired"]),
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "location": location,
    "status": status,
    "category": category,
    "expired": expired.toJson(),
    "icon": icon,
  };
}

class Expired {
  String statusText;
  String statusColor;

  Expired({
    required this.statusText,
    required this.statusColor,
  });

  factory Expired.fromJson(Map<String, dynamic> json) => Expired(
    statusText: json["status_text"],
    statusColor: json["status_color"],
  );

  Map<String, dynamic> toJson() => {
    "status_text": statusText,
    "status_color": statusColor,
  };
}

class TotalItems {
  int total;
  int fresh;
  int expiring;
  int expired;

  TotalItems({
    required this.total,
    required this.fresh,
    required this.expiring,
    required this.expired,
  });

  factory TotalItems.fromJson(Map<String, dynamic> json) => TotalItems(
    total: json["total"],
    fresh: json["fresh"],
    expiring: json["expiring"],
    expired: json["expired"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "fresh": fresh,
    "expiring": expiring,
    "expired": expired,
  };
}
