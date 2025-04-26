import 'package:flutter/material.dart';
import 'package:mobtox/core/models/node.dart';

class NodeCard extends StatelessWidget {
  final Node node;
  final VoidCallback? onToggle;

  const NodeCard({
    super.key,
    required this.node,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: Icon(
          node.isTcp ? Icons.cable : Icons.wifi,
          color: node.isActive ? Colors.green : Colors.grey,
        ),
        title: Text(node.ip),
        subtitle: Text('Port: ${node.port}'),
        trailing: Switch(
          value: node.isActive,
          onChanged: (_) => onToggle?.call(),
        ),
        onTap: () => _showNodeDetails(context),
      ),
    );
  }

  void _showNodeDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Node Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('IP: ${node.ip}'),
            Text('Port: ${node.port}'),
            Text('Type: ${node.isTcp ? 'TCP' : 'UDP'}'),
            Text('Status: ${node.isActive ? 'Active' : 'Inactive'}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}