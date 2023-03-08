import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/item_size.dart';

class Product extends ChangeNotifier {
  Product.fromDocment(DocumentSnapshot document) {
    pid = document.id;
    name = document.get('name');
    description = document.get('description');
    images = List<String>.from(document.get('images'));

    sizes = (document.get('sizes') as List<dynamic>)
        .map((s) => ItemSize.fromMap(s))
        .toList();
  }

  String? pid;
  String? name;
  String? description;
  List<String>? images;

  List<ItemSize>? sizes;

  // pesquisa tamanho
  ItemSize? _selectedSize;
  ItemSize? get selectedSize => _selectedSize;
  set selectedSize(ItemSize? value) {
    _selectedSize = value;
    notifyListeners();
  }

  int? get totalStock {
    int stock = 0;
    for (final size in sizes!) {
      stock += size.stock!;
    }
    return stock;
  }

  // saber se tem estoque total
  bool get hasStock => totalStock! > 0;

  num get basePrice {
    num lowest = double.infinity;
    for (final size in sizes!) {
      // caso queira verificar se tem também no estoque
      if (size.price! < lowest && size.hasStock) lowest = size.price!;
    }
    return lowest;
  }

  ItemSize? findSize(String name) {
    try {
      return sizes!.firstWhere((s) => s.name == name);
    } catch (e) {
      return null;
    }
  }
}
