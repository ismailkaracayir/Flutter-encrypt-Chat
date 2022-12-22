import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kiriptoloji_proje_app/firebase_options.dart';
import 'package:kiriptoloji_proje_app/locator.dart';
import 'package:kiriptoloji_proje_app/pages/key_page.dart';
import 'package:kiriptoloji_proje_app/repository/message_repository.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MessageRepository(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: const KeyPage(),
      ),
    );
  }
}
