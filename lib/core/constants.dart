class AppConstants {
  static const List<Map<String, dynamic>> defaultNodes = [
    {
      'ip': '144.217.167.73',
      'port': 33445,
      'public_key': '6FC41FAB670520E8B2A3657A3B2D7C6F80C3B1C2CA7434901FC795B2B9B2D517',
      'is_tcp': false,
      'enabled': true
    },
    {
      'ip': '178.62.250.138',
      'port': 33445,
      'public_key': '788236D34978D1D5BD822F0A5BEBD2C53C64CC31CD3149350EE27D4D9A2F9B6B',
      'is_tcp': true,
      'enabled': true
    }
  ];

  static const int messageMaxLength = 1366;
  static const int reconnectInterval = 30; // seconds
}