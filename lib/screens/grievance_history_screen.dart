import 'package:flutter/material.dart';
import 'package:grievance_mobile/models/grievance.dart';
import 'package:grievance_mobile/providers/grievance_provider.dart';
import 'package:grievance_mobile/screens/grievance_detail_screen.dart';
import 'package:grievance_mobile/utils/colors.dart';
import 'package:provider/provider.dart';

class GrievanceHistoryScreen extends StatefulWidget {
  const GrievanceHistoryScreen({Key? key}) : super(key: key);

  @override
  State<GrievanceHistoryScreen> createState() => _GrievanceHistoryScreenState();
}

class _GrievanceHistoryScreenState extends State<GrievanceHistoryScreen> {
  String selectedTab = 'Pending'; // Track the selected tab

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GrievanceProvider>(context, listen: false).loadGrievances();
    });
  }

  @override
  Widget build(BuildContext context) {
    final grievanceProvider = Provider.of<GrievanceProvider>(context);
    final grievances = selectedTab == 'Pending'
        ? grievanceProvider.receivedGrievancesList
        : selectedTab == 'In Progress'
            ? grievanceProvider.inProgressGrievancesList
            : grievanceProvider.closedGrievancesList;

    return Scaffold(
      body: Column(
        children: [
          // Tab buttons for filtering grievances
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                _buildTabButton('Pending', selectedTab == 'Pending'),
                const SizedBox(width: 8),
                _buildTabButton('In Progress', selectedTab == 'In Progress'),
                const SizedBox(width: 8),
                _buildTabButton('Completed', selectedTab == 'Completed'),
              ],
            ),
          ),
          // List of grievances
          Expanded(
            child: grievances.isEmpty
                ? const Center(child: Text('No grievances found.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: grievances.length,
                    itemBuilder: (context, index) {
                      return _buildGrievanceCard(grievances[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, bool isSelected) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          setState(() {
            selectedTab = text;
          });
        },
        style: TextButton.styleFrom(
          backgroundColor:
              isSelected ? AppColors.primaryColor : Colors.grey[300],
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildGrievanceCard(Grievance grievance) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GrievanceDetailsPage(grievance: grievance),
          ),
        );
      },
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                grievance.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                grievance.description,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      grievance.dueDate != null
                          ? Text("Due Date: ${grievance.dueDate}")
                          : const Text("This grievance isn't assigned yet.")
                    ],
                  ),
                  Text(
                    grievance.status,
                    style: TextStyle(
                      color: grievance.status.toLowerCase() == 'pending'
                          ? Colors.orange
                          : grievance.status.toLowerCase() == 'in progress'
                              ? Colors.blue
                              : Colors.green,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
