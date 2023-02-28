class SectionItem {
  SectionItem.fromMap(Map<String, dynamic> map) {
    image = map['image'] as String;
  }

  String? image;
  String? product;

  @override
  String toString() {
    return '\nImege: $image';
  }
}
