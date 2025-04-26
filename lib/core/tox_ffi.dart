import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:hex/hex.dart';

final DynamicLibrary _loadToxLib() {
  if (Platform.isAndroid) {
    try {
      return DynamicLibrary.open('libtox.so');
    } catch (e) {
      throw Exception('Failed to load tox library: $e');
    }
  } else if (Platform.isIOS) {
    return DynamicLibrary.process();
  }
  throw UnsupportedError('Platform not supported');
}

final toxLib = _loadToxLib();

class ToxFFI {
  late Pointer<Void> _tox;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    _tox = toxLib.lookupFunction<Pointer<Void> Function(), Pointer<Void> Function()>(
      'tox_new'
    )();
    
    _isInitialized = true;
  }

  int sendMessage(String contactId, String message) {
    if (!_isInitialized) throw Exception('Tox not initialized');
    
    final msgPtr = message.toNativeUtf8();
    final contactPtr = contactId.toNativeUtf8();
    
    try {
      return toxLib.lookupFunction<
        Int32 Function(Pointer<Void>, Pointer<Char>, Pointer<Uint8>, Uint32),
        int Function(Pointer<Void>, Pointer<Char>, Pointer<Uint8>, int)
      >('tox_send_message')(_tox, contactPtr, msgPtr.cast(), message.length);
    } finally {
      calloc.free(msgPtr);
      calloc.free(contactPtr);
    }
  }

  void dispose() {
    if (_isInitialized) {
      toxLib.lookupFunction<Void Function(Pointer<Void>), void Function(Pointer<Void>)>(
        'tox_kill'
      )(_tox);
    }
  }
}
