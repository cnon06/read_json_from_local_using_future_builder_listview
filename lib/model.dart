// To parse required this JSON data, do
//
//     final car = carFromJson(jsonString);

import 'dart:convert';

List<Car> carFromJson(String str) => List<Car>.from(json.decode(str).map((x) => Car.fromJson(x)));

String carToJson(List<Car> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Car {
    Car({
        required this.brand,
        required this.country,
        required this.foundationYear,
        required this.models,
    });

    String brand;
    String country;
    int foundationYear;
    List<Model> models;

    factory Car.fromJson(Map<String, dynamic> json) => Car(
        brand: json["brand"],
        country: json["country"],
        foundationYear: json["foundation_year"],
        models: List<Model>.from(json["models"].map((x) => Model.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "brand": brand,
        "country": country,
        "foundation_year": foundationYear,
        "models": List<dynamic>.from(models.map((x) => x.toJson())),
    };
}

class Model {
    Model({
        required this.modelName,
        required this.price,
        required this.isAutomatic,
    });

    String modelName;
    int price;
    bool isAutomatic;

    factory Model.fromJson(Map<String, dynamic> json) => Model(
        modelName: json["model_name"],
        price: json["price"],
        isAutomatic: json["isAutomatic"],
    );

    Map<String, dynamic> toJson() => {
        "model_name": modelName,
        "price": price,
        "isAutomatic": isAutomatic,
    };
}
