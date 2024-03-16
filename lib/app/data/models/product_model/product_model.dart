import 'package:hive/hive.dart';

part 'product_model.g.dart'; // Add this line to generate the Hive adapter

@HiveType(typeId: 0)
class ProductModel {
  @HiveField(0) // Add HiveField annotation with a unique index for each field
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  double? price;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? category;
  @HiveField(5)
  String? image;
  @HiveField(6)
  Rating? rating;
  @HiveField(7)
  bool? isfavourite;
  @HiveField(8)
  String? size;
  @HiveField(9)
  int? quantity;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
    this.isfavourite = false,
    this.size = "M",
    this.quantity = 1,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating?.toJson(),
      };
}

@HiveType(typeId: 1)
class Rating {
  @HiveField(0)
  double? rate;
  @HiveField(1)
  int? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}
