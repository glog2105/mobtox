import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobtox/core/tox_service.dart';
import 'package:mobtox/ui/screens/chat_screen.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = context.watch<ToxService>().contacts;

    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (_, index) => ListTile(
          leading: CircleAvatar(
            child: Text(contacts[index].alias[0]),
          ),
          title: Text(contacts[index].alias),
          subtitle: Text(contacts[index].toxId.substring(0, 16)),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatScreen(contactId: contacts[index].toxId),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    // Реализация диалога добавления контакта
  }
}