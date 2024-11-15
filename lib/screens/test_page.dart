// lib/screens/grievance_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/grievance_provider.dart';
import '../widgets/grievance_card.dart';

class GrievanceListScreen extends StatefulWidget {
  @override
  _GrievanceListScreenState createState() => _GrievanceListScreenState();
}

class _GrievanceListScreenState extends State<GrievanceListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch grievances when the screen is initialized
    Provider.of<GrievanceProvider>(context, listen: false).loadGrievances();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grievances'),
      ),
      body: Consumer<GrievanceProvider>(
        builder: (context, provider, child) {
          if (provider.grievances.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: provider.grievances.length,
            itemBuilder: (context, index) {
              final grievance = provider.grievances[index];
              return GrievanceCard(grievance: grievance);
            },
          );
        },
      ),
    );
  }
}
