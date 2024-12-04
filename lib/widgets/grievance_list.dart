import 'package:flutter/material.dart';
import 'package:grievance_mobile/models/grievance.dart';
import 'package:grievance_mobile/providers/grievance_provider.dart';
import 'package:grievance_mobile/screens/grievance_detail_screen.dart';
import 'package:provider/provider.dart';

class GrievanceList extends StatefulWidget {
  const GrievanceList({super.key});

  @override
  State<GrievanceList> createState() => _GrievanceListState();
}

class _GrievanceListState extends State<GrievanceList> {
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GrievanceProvider>(context, listen: false).loadGrievances();
    });
  }

  Widget _buildGrievanceItem(BuildContext context, Grievance grievance) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    GrievanceDetailsPage(grievance: grievance)));
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 40,
              color: Colors.blue,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${grievance.title.length > 30 ? grievance.title.substring(0, 30) + '...' : grievance.title}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${grievance.description.length > 50 ? grievance.description.substring(0, 50) + '...' : grievance.description}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final grievances = Provider.of<GrievanceProvider>(context).grievances;

    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Current Grievance',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Below is the list of your submitted grievances.',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: grievances.length,
          itemBuilder: (context, index) {
            return _buildGrievanceItem(
              context,
              grievances[index],
            );
          },
        ),
      ],
    );
  }
}
