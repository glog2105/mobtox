class Message {
  final String id;
  final String text;
  final DateTime timestamp;
  final bool isOutgoing;
  final MessageStatus status;

  const Message({
    required this.id,
    required this.text,
    required this.timestamp,
    this.isOutgoing = false,
    this.status = MessageStatus.sent,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as String,
      text: map['text'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      isOutgoing: map['is_outgoing'] as bool? ?? false,
      status: MessageStatus.values[(map['status'] as int? ?? 0)],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'is_outgoing': isOutgoing,
      'status': status.index,
    };
  }
}

enum MessageStatus {
  sent,
  delivered,
  read,
  error,
}
