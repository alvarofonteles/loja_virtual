import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/section_item.dart';

class Section {
  Section.fromDocument(DocumentSnapshot doc) {
    name = doc.get('name');
    type = doc.get('type');

    items = (doc.get('items') as List)
        .map((i) => SectionItem.fromMap(i as Map<String, dynamic>))
        .toList();
  }

  String? name;
  String? type;
  List<SectionItem?>? items;

  @override
  String toString() {
    return '\nNome: $name, Tipo: $type, Itens: $items';
  }
}
