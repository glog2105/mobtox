import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobtox/core/tox_ffi.dart';
import 'package:mobtox/core/models/contact.dart';
import 'package:mobtox/core/models/message.dart';

class ToxService with ChangeNotifier {
  final ToxFFI _tox;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final List<Contact> _contacts = [];
  bool _isConnected = false;
  DateTime? _lastKeyRotation;

  ToxService(this._tox);

  // Getters
  List<Contact> get contacts => _contacts;
  bool get isConnected => _isConnected;

  Future<void> initialize() async {
    try {
      await _tox.initialize();
      await _loadContacts();
      await _checkKeyRotation();
      _isConnected = true;
      notifyListeners();
    } catch (e) {
      log('Initialization failed: $e', error: e);
      rethrow;
    }
  }

  Future<void> sendMessage(String contactId, String text) async {
    try {
      final message = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: text,
        timestamp: DateTime.now(),
        isOutgoing: true,
      );
      
      await _tox.sendMessage(contactId, text);
      _addMessageToContact(contactId, message);
    } catch (e) {
      log('Message send failed: $e', error: e);
      rethrow;
    }
  }

  Future<void> _checkKeyRotation() async {
    final lastRot = await _secureStorage.read(key: 'last_key_rotation');
    if (lastRot == null || DateTime.now().difference(DateTime.parse(lastRot)).inDays > 7) {
      await _rotateKeys();
    }
  }

  Future<void> _rotateKeys() async {
    // Реализация ротации ключей через FFI
    await _secureStorage.write(
      key: 'last_key_rotation',
      value: DateTime.now().toIso8601String()
    );
    notifyListeners();
  }

  Future<void> _loadContacts() async {
    // Загрузка из базы данных
  }

  void _addMessageToContact(String contactId, Message message) {
    // Логика добавления сообщения
  }
}
