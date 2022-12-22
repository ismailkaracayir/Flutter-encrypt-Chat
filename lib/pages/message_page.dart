import 'package:flutter/material.dart';
import 'package:kiriptoloji_proje_app/models/message.dart';
import 'package:kiriptoloji_proje_app/pages/encrypted_page.dart';
import 'package:kiriptoloji_proje_app/repository/message_repository.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late TextEditingController messageController;
  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<MessageRepository>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesaj gönderme'),
        actions: [
          TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const EncryptedPage(),
                ));
              },
              icon: const Icon(
                Icons.arrow_circle_right,
                color: Colors.white,
              ),
              label: const Text(
                'Şifreli Akış',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: repo.getMessages(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<Message> allMessage = snapshot.data!;

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
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  cursorColor: Colors.blueGrey,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Mesajınızı Yazın",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                child: FloatingActionButton(
                    elevation: 0,
                    backgroundColor: Colors.deepOrange.shade300,
                    child: const Icon(
                      Icons.navigate_next,
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      sendMessage(messageController.text);
                      messageController.clear();
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }

  void sendMessage(String plainText) {
    final repo = Provider.of<MessageRepository>(context, listen: false);
    repo.sendMessage(plainText);
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
