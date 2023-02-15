import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({this.email, this.password, this.name, this.id});

  // versao da aula
  /*User.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
  }*/

  User.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document.get('name');
    email = document.get('email');
  }

  String? email;
  String? password; // 123456
  String? name;
  String? id;

  String? confirmPassword;

  // 3ª opcao com reference
  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  Future<void> saveData() async {
    // 1ª opcao
    //  await FirebaseFirestore.instance.collection('users').doc(id).set(toMap());
    // 2ª opcao
    //  await FirebaseFirestore.instance.doc('users/$id').set(toMap());
    // 3ª opcao com reference
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}
