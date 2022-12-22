import 'package:flutter/cupertino.dart';
import 'package:kiriptoloji_proje_app/locator.dart';
import 'package:kiriptoloji_proje_app/models/message.dart';
import 'package:kiriptoloji_proje_app/repository/crypto_repository.dart';
import 'package:kiriptoloji_proje_app/services/firestore_db.dart';

class MessageRepository extends ChangeNotifier {
  final FirebaseDB firebaseDB = getIt<FirebaseDB>();
  final CryptoRepository cryptoRepo = getIt<CryptoRepository>();

  String key = '';
  Map<String, String> decryptedToList = {"mesaj": ''};

  Future<bool> keysubmit(String sendKey) async {
    if (sendKey.isEmpty) {
      return false;
    }
    key = sendKey;
    return true;
  }

  Future<bool> sendMessage(String plainText) async {
    String cryptoTexy = cryptoRepo.encrypted(key, plainText);
    if (cryptoTexy.isNotEmpty) {
      debugPrint('ŞİFRELENMİŞ METİN:: $cryptoTexy');
      await firebaseDB.sendMessage(cryptoTexy);
      return true;
    }
    return false;
  }

  Stream<List<Message>> getMessagesEncrypted() {
    Stream<List<Message>> allMessage = firebaseDB.getMessagesEncrypted();
    return allMessage.asBroadcastStream();
  }

  Stream<List<Message>> getMessages() {
    var allMessage = firebaseDB.getMessagesEncrypted();
    try {
      allMessage.listen((event) {}).onData((data) {
        for (var i = 0; i < data.length; i++) {
          String decrypted = cryptoRepo.decrypted(data[i].mesaj!);
          data[i].mesaj = decrypted;
          debugPrint('message_repo da şifre çözme çalıştı $decrypted');
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }

    return allMessage.asBroadcastStream();
  }
}
