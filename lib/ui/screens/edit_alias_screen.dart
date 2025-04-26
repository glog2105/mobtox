import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobtox/core/tox_service.dart';

class EditAliasScreen extends StatefulWidget {
  final String contactId;
  
  const EditAliasScreen({super.key, required this.contactId});

  @override
  State<EditAliasScreen> createState() => _EditAliasScreenState();
}

class _EditAliasScreenState extends State<EditAliasScreen> {
  final _aliasController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCurrentAlias();
  }

  Future<void> _loadCurrentAlias() async {
    final alias = await context.read<ToxService>().getAlias(widget.contactId);
    _aliasController.text = alias;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Alias'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveAlias,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _aliasController,
          decoration: const InputDecoration(
            labelText: 'Alias',
            hintText: 'Enter contact name',
          ),
        ),
      ),
    );
  }

  void _saveAlias() {
    context.read<ToxService>().updateAlias(
      widget.contactId,
      _aliasController.text.trim(),
    );
    Navigator.pop(context);
  }
}