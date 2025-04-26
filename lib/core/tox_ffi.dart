import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:hex/hex.dart';

final DynamicLibrary _toxLib = _loadToxLibrary();

DynamicLibrary _loadToxLibrary() {
  if (Platform.isAndroid) {
    return DynamicLibrary.open('libtox.so');
  } else if (Platform.isIOS) {
    return DynamicLibrary.open('libtox.dylib');
  }
  throw UnsupportedError('Platform not supported');
}

class ToxFFI {
  late Pointer<Void> _toxPointer;

  void initialize() {
    _toxPointer = _toxLib.lookupFunction<Pointer<Void> Function(), Pointer<Void> Function()>('tox_new')();
  }

  void bootstrapNode(String ip, int port, String publicKey) {
    final ipPtr = ip.toNativeUtf8();
    final keyPtr = Uint8List.fromList(HEX.decode(publicKey)).allocatePointer();

    _toxLib.lookupFunction<
      Void Function(Pointer<Void>, Pointer<Char>, Uint16, Pointer<Uint8>),
      void Function(Pointer<Void>, Pointer<Char>, int, Pointer<Uint8>)
    >('tox_bootstrap')(_toxPointer, ipPtr, port, keyPtr);

    calloc.free(ipPtr);
    calloc.free(keyPtr);
  }

  int sendMessage(String contactId, String message) {
    final msgPtr = message.toNativeUtf8();
    final result = _toxLib.lookupFunction<
      Int32 Function(Pointer<Void>, Pointer<Char>, Pointer<Uint8>, Uint32),
      int Function(Pointer<Void>, Pointer<Char>, Pointer<Uint8>, int)
    >('tox_send_message')(_toxPointer, contactId.toNativeUtf8(), msgPtr.cast(), message.length);

    calloc.free(msgPtr);
    return result;
  }

  void dispose() {
    _toxLib.lookupFunction<Void Function(Pointer<Void>), void Function(Pointer<Void>)>('tox_kill')(_toxPointer);
  }
}