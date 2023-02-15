import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void fireStore() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /*FirebaseFirestore.instance.collection('pedidos').add({
    'preco': 199.99,
    'usuario': 'Fco Willian',
  });*/

  /*FirebaseFirestore.instance.collection('produtos').doc('SmartTV').set({
    'nome': 'Samsung',
    'descricao': 'Linha Samsung Expert',
  });*/

  /*FirebaseFirestore.instance.collection('pedidos').doc('PmccsIMh8wM47EtkKqo2').update({
    'usuario': 'Fco Willian Alves',
  });*/

  /*FirebaseFirestore.instance.doc('pedidos/PmccsIMh8wM47EtkKqo2').update({
    'preco': 299.99,
    'usuario': 'Fco Willian',
  });*/

  /*DocumentSnapshot docPedido1 = await FirebaseFirestore.instance
      .doc('pedidos/PmccsIMh8wM47EtkKqo2')
      .get();

  debugPrint(docPedido1.data().toString());
  debugPrint(docPedido1.get('usuario'));

  FirebaseFirestore.instance
      .doc('pedidos/PmccsIMh8wM47EtkKqo2')
      .snapshots()
      .listen((docPedido) {
    // debugPrint(docPedido.get('nome'));
    debugPrint(docPedido.get('preco').toString());
  });*/

  /*FirebaseFirestore.instance.collection('produtos').doc('SmartTV').update({
    'descricao': 'Linha Samsung Expert NP350',
  });*/

  /*FirebaseFirestore.instance.doc('produtos/SmartTV').update({
    'descricao': 'Linha Samsung Expert NP350X',
  });*/

  /*DocumentSnapshot docProduto =
      await FirebaseFirestore.instance.doc('produtos/SmartTV').get();

  debugPrint(docProduto.data().toString());
  debugPrint(docProduto.get('descricao'));

  FirebaseFirestore.instance
      .doc('produtos/SmartTV')
      .snapshots()
      .listen((docProduto) {
    debugPrint(docProduto.get('nome'));
    debugPrint(docProduto.get('descricao'));
  });*/

  /*QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('produtos').get();

  debugPrint(snapshot.docs.toString());

  for (DocumentSnapshot document in snapshot.docs) {
    //debugPrint(document.data().toString());
    debugPrint(document.get('descricao'));
  }*/

  FirebaseFirestore.instance
      .collection('produtos')
      .snapshots()
      .listen((snapshot) {
    for (DocumentSnapshot documentSnapshot in snapshot.docs) {
      // debugPrint(documentSnapshot.data().toString());
      debugPrint(documentSnapshot.get('nome'));
      debugPrint(documentSnapshot.get('descricao'));
    }
  });

  // FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
}
