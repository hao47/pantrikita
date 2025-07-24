// To parse this JSON data, do
//
//     final home = homeFromJson(jsonString);

import 'dart:convert';

Home homeFromJson(String str) => Home.fromJson(json.decode(str));

String homeToJson(Home data) => json.encode(data.toJson());

class Home {
  String messsage;
  Data data;

  Home({
    required this.messsage,
    required this.data,
  });

  factory Home.fromJson(Map<String, dynamic> json) => Home(
    messsage: json["messsage"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "messsage": messsage,
    "data": data.toJson(),
  };
}

class Data {
  AttentionNeeded attentionNeeded;
  Total total;
  List<Item> items;

  Data({
    required this.attentionNeeded,
    required this.total,
    required this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    attentionNeeded: AttentionNeeded.fromJson(json["attention_needed"]),
    total: Total.fromJson(json["total"]),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "attention_needed": attentionNeeded.toJson(),
    "total": total.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class AttentionNeeded {
  bool isNeeded;
  String content;

  AttentionNeeded({
    required this.isNeeded,
    required this.content,
  });

  factory AttentionNeeded.fromJson(Map<String, dynamic> json) => AttentionNeeded(
    isNeeded: json["is_needed"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "is_needed": isNeeded,
    "content": content,
  };
}

class Item {
  String id;
  String name;
  String location;
  String status;
  String category;
  String icon;
  Expired expired;

  Item({
    required this.id,
    required this.name,
    required this.location,
    required this.status,
    required this.category,
    required this.icon,
    required this.expired,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    name: json["name"],
    location: json["location"],
    status: json["status"],
    category: json["category"],
    icon: json["icon"],
    expired: Expired.fromJson(json["expired"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "location": location,
    "status": status,
    "category": category,
    "icon": icon,
    "expired": expired.toJson(),
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

class Total {
  int totalItems;
  int expiringSoon;

  Total({
    required this.totalItems,
    required this.expiringSoon,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
    totalItems: json["total_items"],
    expiringSoon: json["expiring_soon"],
  );

  Map<String, dynamic> toJson() => {
    "total_items": totalItems,
    "expiring_soon": expiringSoon,
  };
}
