import 'package:flutter/cupertino.dart';
import 'package:encrypt/encrypt.dart' as cripto;
import 'package:kiriptoloji_proje_app/repository/dolgu_bit.dart';

class CryptoRepository {
  cripto.Key? key;
  cripto.IV? iv;
  cripto.Encrypter? encrypter;

  String encrypted(String _key, String plainText) {
    int deger = _key.length.toInt();
    if (deger < 32) {
      String temp = '';
      for (var i = 0; i < 32 - deger; i++) {
        temp += DolguBit.allow[i];
      }
      _key = _key + temp;
    }
    if (deger > 32) {
      _key = _key.substring(0, 32);
    }
    key = cripto.Key.fromUtf8(_key);
    iv = cripto.IV.fromLength(16);
    encrypter = cripto.Encrypter(cripto.AES(key!));
    var encrypted = encrypter!.encrypt(plainText, iv: iv);
    return encrypted.base64;
    // print(encrypted);
  }

  String decrypted(String base64Text) {
    var decrypted = encrypter!.decrypt64(base64Text, iv: iv);
    debugPrint('crypto_repo da şifre çözme çalıştı $decrypted');
    return decrypted;
  }
}
