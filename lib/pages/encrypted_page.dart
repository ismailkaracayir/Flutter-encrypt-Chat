import 'package:flutter/material.dart';
import 'package:kiriptoloji_proje_app/models/message.dart';
import 'package:kiriptoloji_proje_app/repository/message_repository.dart';
import 'package:provider/provider.dart';

class EncryptedPage extends StatefulWidget {
  const EncryptedPage({super.key});

  @override
  State<EncryptedPage> createState() => _EncryptedPageState();
}

class _EncryptedPageState extends State<EncryptedPage> {
  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<MessageRepository>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Şifreli Akış'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: repo.getMessagesEncrypted(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<Message> allMessage = snapshot.data ?? [];

                return ListView.builder(
                  itemCount: allMessage.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: chatWidgetCreate(allMessage[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget chatWidgetCreate(Message allMessage) {
    var takeMessageColor = Colors.deepOrange.shade200;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: takeMessageColor,
            ),
            child: Text(allMessage.mesaj!),
          )
        ],
      ),
    );
  }
}
