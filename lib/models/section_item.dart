class SectionItem {
  SectionItem.fromMap(Map<String, dynamic> map) {
    image = map['image'] as String;
    product = map['product'];
  }

  String? image;
  String? product;
}
