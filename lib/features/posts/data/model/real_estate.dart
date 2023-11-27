// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class RealEstateModel {
  final int id;
  final String properyName;
  late final String photo;
  final String location;
  final String price;
  File? imageFile;
  final String size;
  final String description;

  RealEstateModel({
    required this.id,
    required this.properyName,
    required this.photo,
    required this.location,
    required this.price,
    required this.size,
    required this.description,
  });

  RealEstateModel copyWith({
    int? id,
    String? properyName,
    String? photo,
    String? location,
    String? price,
    String? size,
    String? description,
  }) {
    return RealEstateModel(
      id: id ?? this.id,
      properyName: properyName ?? this.properyName,
      photo: photo ?? this.photo,
      location: location ?? this.location,
      price: price ?? this.price,
      size: size ?? this.size,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'properyName': properyName,
      'photo': photo,
      'location': location,
      'price': price,
      'size': size,
      'description': description,
    };
  }

  factory RealEstateModel.fromMap(Map<String, dynamic> map) {
    return RealEstateModel(
      id: map['id'] as int,
      properyName: map['properyName'] as String,
      photo: map['photo'] as String,
      location: map['location'] as String,
      price: map['price'] as String,
      size: map['size'] as String,
      description: map['description'] as String,
    );
  }

  factory RealEstateModel.fromSnapshot(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RealEstateModel(
      id: data['id'] as int,
      properyName: data['properyName'] as String,
      photo: data['photo'] as String,
      location: data['location'] as String,
      price: data['price'] as String,
      size: data['size'] as String,
      description: data['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'RealEstateModel(id: $id, properyName: $properyName, photo: $photo, location: $location, price: $price, size: $size, description: $description)';
  }

  @override
  bool operator ==(covariant RealEstateModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.properyName == properyName &&
      other.photo == photo &&
      other.location == location &&
      other.price == price &&
      other.size == size &&
      other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      properyName.hashCode ^
      photo.hashCode ^
      location.hashCode ^
      price.hashCode ^
      size.hashCode ^
      description.hashCode;
  }

  factory RealEstateModel.fromJson(String source) => RealEstateModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
