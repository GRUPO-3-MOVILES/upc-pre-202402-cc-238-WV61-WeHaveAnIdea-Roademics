import 'package:flutter/material.dart';
import 'package:roademics/domain/roadmaps/entities/edge_entity.dart';

class EdgeWidget extends StatelessWidget {
  final Edge edge;

  const EdgeWidget({Key? key, required this.edge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${edge.fromNodeId} -> ${edge.toNodeId}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(edge.label),
            Text(edge.description),
          ],
        ),
        trailing: Text(edge.relationshipType),
      ),
    );
  }
}
