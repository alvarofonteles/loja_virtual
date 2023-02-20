import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/item_size.dart';

import 'package:flutter/material.dart';

class Product {
  Product.fromDocment(DocumentSnapshot document) {
    id = document.id;
    name = document.get('name');
    description = document.get('description');
    images = List<String>.from(document.get('images'));

    sizes = (document.get('sizes') as List<dynamic>)
        .map((s) => ItemSize.fromMap(s))
        .toList();

    debugPrint('$name: ${sizes.toString()}');
  }

  String? id;
  String? name;
  String? description;
  List<String>? images;

  List<ItemSize>? sizes;
}
