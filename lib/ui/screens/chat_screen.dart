import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobtox/core/tox_service.dart';
import 'package:mobtox/ui/widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  final String contactId;
  
  const ChatScreen({super.key, required this.contactId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final contact = context.select<ToxService, Contact?>(
      (service) => service.getContact(widget.contactId),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(contact?.alias ?? contact?.name ?? 'Unknown'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessagesList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    // Реализация списка сообщений
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(hintText: 'Type a message...'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      context.read<ToxService>().sendMessage(widget.contactId, message);
      _messageController.clear();
    }
  }
}