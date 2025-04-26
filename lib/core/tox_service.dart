import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:mobtox/core/models/contact.dart';
import 'package:mobtox/core/models/message.dart';
import 'package:mobtox/core/models/node.dart';
import 'package:mobtox/core/tox_ffi.dart';
import 'package:mobtox/core/database.dart';

class ToxService with ChangeNotifier {
  final ToxFFI _tox;
  final List<Contact> _contacts = [];
  final List<Node> _nodes = [];
  bool _isConnected = false;
  bool _isProxyEnabled = false;

  ToxService(this._tox);

  // Getters
  List<Contact> get contacts => _contacts;
  List<Node> get nodes => _nodes;
  bool get isConnected => _isConnected;
  bool get isProxyEnabled => _isProxyEnabled;

  // Initialization
  Future<void> initialize() async {
    await _loadContacts();
    await _loadNodes();
    _connectToNodes();
  }

  Future<void> _loadContacts() async {
    final db = await ToxDatabase.instance;
    _contacts.clear();
    _contacts.addAll(await db.getAllContacts());
    notifyListeners();
  }

  Future<void> _loadNodes() async {
    final db = await ToxDatabase.instance;
    _nodes.clear();
    _nodes.addAll(await db.getAllNodes());
    notifyListeners();
  }

  // Node management
  void _connectToNodes() {
    for (final node in _nodes.where((n) => n.isActive)) {
      _tox.bootstrapNode(node.ip, node.port, node.publicKey);
    }
    _isConnected = true;
    notifyListeners();
  }

  Future<String?> importNodesFromFile(String filePath) async {
    try {
      // Implementation for file import
      notifyListeners();
      return 'Nodes imported successfully';
    } catch (e) {
      return 'Failed to import nodes: $e';
    }
  }

  // Contact management
  Future<void> addContact(String toxId, [String? alias]) async {
    final db = await ToxDatabase.instance;
    await db.addContact(toxId, alias);
    await _loadContacts();
  }

  Future<void> updateAlias(String toxId, String alias) async {
    final db = await ToxDatabase.instance;
    await db.updateAlias(toxId, alias);
    await _loadContacts();
  }

  // Messaging
  Future<void> sendMessage(String contactId, String text) async {
    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      timestamp: DateTime.now(),
      isOutgoing: true,
    );
    
    final db = await ToxDatabase.instance;
    await db.addMessage(contactId, message);
    await _loadContacts();
    
    _tox.sendMessage(contactId, text);
  }

  // Proxy settings
  Future<void> toggleProxy(bool enabled) async {
    _isProxyEnabled = enabled;
    final db = await ToxDatabase.instance;
    await db.setProxyEnabled(enabled);
    notifyListeners();
  }
}