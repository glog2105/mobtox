import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobtox/core/tox_service.dart';
import 'package:mobtox/ui/widgets/node_card.dart';

class NodesScreen extends StatelessWidget {
  const NodesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nodes = context.watch<ToxService>().nodes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nodes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _importNodes(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: nodes.length,
        itemBuilder: (_, index) => NodeCard(node: nodes[index]),
      ),
    );
  }

  Future<void> _importNodes(BuildContext context) async {
    final result = await context.read<ToxService>().importNodesFromFile();
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }
}