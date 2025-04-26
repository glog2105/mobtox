import 'package:flutter/material.dart';
import 'package:mobtox/core/models/contact.dart';

class ContactListItem extends StatelessWidget {
  final Contact contact;
  final VoidCallback? onTap;

  const ContactListItem({
    super.key,
    required this.contact,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Text(
          contact.alias.isNotEmpty 
              ? contact.alias[0].toUpperCase()
              : '?',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(contact.alias),
      subtitle: Text(
        contact.status ?? 'Offline',
        style: TextStyle(
          color: contact.status == 'Online' 
              ? Colors.green 
              : Colors.grey,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}