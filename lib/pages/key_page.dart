import 'package:flutter/material.dart';
import 'package:kiriptoloji_proje_app/pages/message_page.dart';
import 'package:kiriptoloji_proje_app/repository/message_repository.dart';
import 'package:provider/provider.dart';

class KeyPage extends StatefulWidget {
  const KeyPage({super.key});

  @override
  State<KeyPage> createState() => _KeyPageState();
}

class _KeyPageState extends State<KeyPage> {
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anahtarı Giriniz'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
                hintText: 'Anahtarı giriniz',
                filled: true,
                fillColor: Colors.deepOrange.shade100),
            controller: controller,
            onChanged: (value) {
              controller.text = value;
              final val =
                  TextSelection.collapsed(offset: controller.text.length);
              controller.selection = val;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              _keySubmit(controller.text);
              controller.clear();
            },
            child: const Text('Key Degerini Gönder'),
          )
        ],
      ),
    );
  }

  void _keySubmit(String keyText) async {
    final repo = Provider.of<MessageRepository>(context, listen: false);
    bool date = await repo.keysubmit(keyText.trim());
    if (date)  {
        Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const MessagePage(),
      ));
    }
  }
}
