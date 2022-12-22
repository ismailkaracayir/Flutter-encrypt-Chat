import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:kiriptoloji_proje_app/models/message.dart';

class FirebaseDB {
  final FirebaseFirestore firebaseDB = FirebaseFirestore.instance;

  Future<bool> sendMessage(String cryptoTexy) async {
    try {
      Message message = Message(mesaj: cryptoTexy);
      await firebaseDB.collection('message').doc().set(message.toMap());

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Stream<List<Message>> getMessagesEncrypted() {
    var snapShat = firebaseDB.collection('message').orderBy('date').snapshots();
    return snapShat
        .map((event) =>
            event.docs.map((e) => Message.fromMap(e.data())).toList())
        .asBroadcastStream();
  }
}
