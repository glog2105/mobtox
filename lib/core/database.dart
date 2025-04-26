import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mobtox/core/models/contact.dart';
import 'package:mobtox/core/models/message.dart';
import 'package:mobtox/core/models/node.dart';

class ToxDatabase {
  static Database? _instance;
  static const String _dbName = 'mobtox.db';

  static Future<Database> get instance async {
    if (_instance != null) return _instance!;
    _instance = await _initDatabase();
    return _instance!;
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tox_id TEXT UNIQUE,
        name TEXT,
        alias TEXT,
        last_seen INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE messages(
        id TEXT PRIMARY KEY,
        contact_id TEXT,
        text TEXT,
        timestamp INTEGER,
        is_outgoing INTEGER,
        status INTEGER,
        FOREIGN KEY(contact_id) REFERENCES contacts(tox_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE nodes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ip TEXT,
        port INTEGER,
        public_key TEXT UNIQUE,
        is_tcp INTEGER,
        enabled INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE settings(
        key TEXT PRIMARY KEY,
        value TEXT
      )
    ''');
  }

  // Contact methods
  Future<List<Contact>> getAllContacts() async {
    final db = await instance;
    final maps = await db.query('contacts');
    return maps.map((map) => Contact.fromMap(map)).toList();
  }

  Future<void> addContact(String toxId, [String? alias]) async {
    final db = await instance;
    await db.insert('contacts', {
      'tox_id': toxId,
      'name': toxId.substring(0, 8),
      'alias': alias ?? '',
    });
  }

  // Node methods
  Future<List<Node>> getAllNodes() async {
    final db = await instance;
    final maps = await db.query('nodes');
    return maps.map((map) => Node.fromMap(map)).toList();
  }
}