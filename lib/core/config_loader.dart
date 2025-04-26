import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:mobtox/core/models/node.dart';
import 'package:mobtox/core/database.dart';

class ConfigLoader {
  static Future<List<Node>> parseNodesFile(String filePath) async {
    final file = File(filePath);
    final lines = await file.readAsLines();
    
    return lines.map((line) {
      final parts = line.split('|');
      return Node(
        ip: parts[0],
        port: int.parse(parts[1]),
        publicKey: parts[2],
        isTcp: parts.length > 3 && parts[3] == 'tcp',
      );
    }).toList();
  }

  static Future<String?> pickNodesFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );
    return result?.files.single.path;
  }
}