import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.isFavourite,
    this.qty,
  });

  String id, name, image, description;
  double price;
  bool isFavourite;
  int? qty;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      price: double.parse(json["price"].toString()),
      description: json["description"],
      qty: json["qty"],
      isFavourite: false,
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "price": price,
        "isFavourite": isFavourite,
        "qty": qty,

      };


  ProductModel copyWith({
    int? qty,
}) => ProductModel(
    id: id,
    name: name,
    image: image,
    price: price,
    description: description,
    qty: qty ?? this.qty,
    isFavourite: isFavourite,
  );
}
