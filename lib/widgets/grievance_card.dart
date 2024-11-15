// lib/widgets/grievance_card.dart
import 'package:flutter/material.dart';
import '../models/grievance.dart';

class GrievanceCard extends StatelessWidget {
  final Grievance grievance;

  GrievanceCard({required this.grievance});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(grievance.title),
        subtitle: Text(grievance.description),
        trailing: Text(grievance.priority),
        onTap: () {
          // Navigate to detailed grievance page
        },
      ),
    );
  }
}
