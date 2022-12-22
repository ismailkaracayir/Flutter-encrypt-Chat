import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String? kimden;
  final String? kime;
  final bool? bendenMi;
      String? mesaj;
  final Timestamp? date;
  

  Message(
      {this.kimden,
      this.kime,
      this.bendenMi,
      this.mesaj,
      this.date,
      });

  Map<String, dynamic> toMap() {
    return {
      'kimden': kimden,
      'kime': kime,
      'bendenMi': bendenMi,
      'mesaj': mesaj,
      'date': date ?? FieldValue.serverTimestamp(),
    };
  }

  Message.fromMap(Map<String, dynamic> map)
      : kimden = map['kimden'],
        kime = map['kime'],
        bendenMi = map['bendenMi'],
        mesaj = map['mesaj'],
        date = map['date'];

  @override
  String toString() {
    return 'Mesaj{kimden: $kimden, kime: $kime, bendenMi: $bendenMi, mesaj: $mesaj, date: $date}';
  }
}
