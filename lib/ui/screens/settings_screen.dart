import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobtox/core/tox_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Enable Proxy'),
            value: context.watch<ToxService>().isProxyEnabled,
            onChanged: (v) => context.read<ToxService>().toggleProxy(v),
          ),
          ListTile(
            title: const Text('Clear Cache'),
            onTap: () => _clearCache(context),
          ),
        ],
      ),
    );
  }

  void _clearCache(BuildContext context) {
    // Реализация очистки кэша
  }
}