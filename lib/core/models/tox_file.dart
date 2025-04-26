class ToxFile {
  final String id;
  final String name;
  final int size;
  final String filePath;
  final FileTransferStatus status;
  final int progress; // 0-100
  final bool isIncoming;
  final DateTime timestamp;

  const ToxFile({
    required this.id,
    required this.name,
    required this.size,
    required this.filePath,
    this.status = FileTransferStatus.pending,
    this.progress = 0,
    this.isIncoming = true,
    required this.timestamp,
  });
}

enum FileTransferStatus {
  pending,
  transferring,
  completed,
  cancelled,
  error,
}