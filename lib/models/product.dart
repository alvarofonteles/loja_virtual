import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  Product.fromDocment(DocumentSnapshot document) {
    id = document.id;
    name = document.get('name');
    description = document.get('description');
    images = List<String>.from(document.get('images'));
  }

  String? id;
  String? name;
  String? description;
  List<String>? images;
}
