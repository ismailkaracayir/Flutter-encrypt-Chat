import 'package:get_it/get_it.dart';
import 'package:kiriptoloji_proje_app/repository/crypto_repository.dart';
import 'package:kiriptoloji_proje_app/services/firestore_db.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => FirebaseDB());
   getIt.registerLazySingleton(() => CryptoRepository());

}
