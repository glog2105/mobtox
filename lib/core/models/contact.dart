class Contact {
  final String toxId;
  final String name;
  String alias;
  String? status;
  DateTime? lastSeen;
  final List<Message> messages;

  Contact({
    required this.toxId,
    required this.name,
    this.alias = '',
    this.status,
    this.lastSeen,
    this.messages = const [],
  });

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      toxId: map['tox_id'] as String,
      name: map['name'] as String,
      alias: map['alias'] as String? ?? '',
      lastSeen: map['last_seen'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['last_seen'] as int)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tox_id': toxId,
      'name': name,
      'alias': alias,
      'last_seen': lastSeen?.millisecondsSinceEpoch,
    };
  }

  bool get isOnline => status == 'Online';
}