class Node {
  final String ip;
  final int port;
  final String publicKey;
  final bool isTcp;
  bool isActive;

  Node({
    required this.ip,
    required this.port,
    required this.publicKey,
    this.isTcp = false,
    this.isActive = true,
  });

  factory Node.fromMap(Map<String, dynamic> map) {
    return Node(
      ip: map['ip'] as String,
      port: map['port'] as int,
      publicKey: map['public_key'] as String,
      isTcp: map['is_tcp'] as bool? ?? false,
      isActive: map['enabled'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ip': ip,
      'port': port,
      'public_key': publicKey,
      'is_tcp': isTcp,
      'enabled': isActive,
    };
  }

  String get connectionType => isTcp ? 'TCP' : 'UDP';
}