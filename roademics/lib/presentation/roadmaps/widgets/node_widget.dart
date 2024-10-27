import 'package:flutter/material.dart';
import 'package:roademics/domain/roadmaps/entities/node_entity.dart';

class NodeWidget extends StatelessWidget {
  final Node node;

  const NodeWidget({Key? key, required this.node}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(node.title),
        subtitle: Text(node.description),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(node.isStartNode ? 'Start' : ''),
            Text(node.isEndNode ? 'End' : ''),
          ],
        ),
      ),
    );
  }
}
