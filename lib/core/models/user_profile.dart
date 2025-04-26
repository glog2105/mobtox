class UserProfile {
  final String toxId;
  String name;
  String? statusMessage;
  Uint8List? avatar;

  UserProfile({
    required this.toxId,
    required this.name,
    this.statusMessage,
    this.avatar,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      toxId: map['tox_id'] as String,
      name: map['name'] as String,
      statusMessage: map['status_message'] as String?,
      avatar: map['avatar'] as Uint8List?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tox_id': toxId,
      'name': name,
      'status_message': statusMessage,
      'avatar': avatar,
    };
  }
}